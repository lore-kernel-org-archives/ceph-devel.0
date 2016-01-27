From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH V3 6/6] ceph: scattered page writeback
Date: Wed, 27 Jan 2016 17:42:51 +0800
Message-ID: <43AC0102-2144-4FE0-95E3-45204009D412@redhat.com>
References: <1453210244-41777-1-git-send-email-zyan@redhat.com> <CAOi1vP-e4wvEXrb2zFSaqew8NEY8P=6gTss-v-gm=aBr68Euow@mail.gmail.com> <CAAM7YAny_uyGQx9m8VzcdNRCOgciabXh-LW2WQG=qAm4DmafGA@mail.gmail.com> <CAOi1vP_bebLHL1ijXG-67vzUTSNbH=T3k1SQU5MypdAL8JZKmQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49311 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754242AbcA0JnF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 04:43:05 -0500
In-Reply-To: <CAOi1vP_bebLHL1ijXG-67vzUTSNbH=T3k1SQU5MypdAL8JZKmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Zheng Yan <ukernel@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>


> On Jan 27, 2016, at 17:29, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> On Wed, Jan 27, 2016 at 2:52 AM, Yan, Zheng <ukernel@gmail.com> wrote=
:
>> On Wed, Jan 27, 2016 at 6:15 AM, Ilya Dryomov <idryomov@gmail.com> w=
rote:
>>> On Tue, Jan 19, 2016 at 2:30 PM, Yan, Zheng <zyan@redhat.com> wrote=
:
>>>> This patch makes ceph_writepages_start() try using single OSD requ=
est
>>>> to write all dirty pages within a strip. When a nonconsecutive dir=
ty
>>>> page is found, ceph_writepages_start() tries starting a new write
>>>> operation to existing OSD request. If it succeeds, it uses the new
>>>> operation to writeback the dirty page.
>>>>=20
>>>> Signed-off-by: Yan, Zheng <zyan@redhat.com>
>>>> ---
>>>> fs/ceph/addr.c | 263 ++++++++++++++++++++++++++++++++++++++-------=
------------
>>>> 1 file changed, 174 insertions(+), 89 deletions(-)
>>>>=20
>>>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>>>> index c222137..ac14d02 100644
>>>> --- a/fs/ceph/addr.c
>>>> +++ b/fs/ceph/addr.c
>>>> @@ -606,71 +606,71 @@ static void writepages_finish(struct ceph_os=
d_request *req,
>>>>        struct inode *inode =3D req->r_inode;
>>>>        struct ceph_inode_info *ci =3D ceph_inode(inode);
>>>>        struct ceph_osd_data *osd_data;
>>>> -       unsigned wrote;
>>>>        struct page *page;
>>>> -       int num_pages;
>>>> -       int i;
>>>> +       int num_pages, total_pages =3D 0;
>>>> +       int i, j;
>>>> +       int rc =3D req->r_result;
>>>>        struct ceph_snap_context *snapc =3D req->r_snapc;
>>>>        struct address_space *mapping =3D inode->i_mapping;
>>>> -       int rc =3D req->r_result;
>>>> -       u64 bytes =3D req->r_ops[0].extent.length;
>>>>        struct ceph_fs_client *fsc =3D ceph_inode_to_client(inode);
>>>> -       long writeback_stat;
>>>> -       unsigned issued =3D ceph_caps_issued(ci);
>>>> +       bool remove_page;
>>>>=20
>>>> -       osd_data =3D osd_req_op_extent_osd_data(req, 0);
>>>> -       BUG_ON(osd_data->type !=3D CEPH_OSD_DATA_TYPE_PAGES);
>>>> -       num_pages =3D calc_pages_for((u64)osd_data->alignment,
>>>> -                                       (u64)osd_data->length);
>>>> -       if (rc >=3D 0) {
>>>> -               /*
>>>> -                * Assume we wrote the pages we originally sent.  =
The
>>>> -                * osd might reply with fewer pages if our writeba=
ck
>>>> -                * raced with a truncation and was adjusted at the=
 osd,
>>>> -                * so don't believe the reply.
>>>> -                */
>>>> -               wrote =3D num_pages;
>>>> -       } else {
>>>> -               wrote =3D 0;
>>>> +
>>>> +       dout("writepages_finish %p rc %d\n", inode, rc);
>>>> +       if (rc < 0)
>>>>                mapping_set_error(mapping, rc);
>>>> -       }
>>>> -       dout("writepages_finish %p rc %d bytes %llu wrote %d (page=
s)\n",
>>>> -            inode, rc, bytes, wrote);
>>>>=20
>>>> -       /* clean all pages */
>>>> -       for (i =3D 0; i < num_pages; i++) {
>>>> -               page =3D osd_data->pages[i];
>>>> -               BUG_ON(!page);
>>>> -               WARN_ON(!PageUptodate(page));
>>>> +       /*
>>>> +        * We lost the cache cap, need to truncate the page before
>>>> +        * it is unlocked, otherwise we'd truncate it later in the
>>>> +        * page truncation thread, possibly losing some data that
>>>> +        * raced its way in
>>>> +        */
>>>> +       remove_page =3D !(ceph_caps_issued(ci) &
>>>> +                       (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)=
);
>>>>=20
>>>> -               writeback_stat =3D
>>>> -                       atomic_long_dec_return(&fsc->writeback_cou=
nt);
>>>> -               if (writeback_stat <
>>>> -                   CONGESTION_OFF_THRESH(fsc->mount_options->cong=
estion_kb))
>>>> -                       clear_bdi_congested(&fsc->backing_dev_info=
,
>>>> -                                           BLK_RW_ASYNC);
>>>> +       /* clean all pages */
>>>> +       for (i =3D 0; i < req->r_num_ops; i++) {
>>>> +               if (req->r_ops[i].op !=3D CEPH_OSD_OP_WRITE)
>>>> +                       break;
>>>>=20
>>>> -               ceph_put_snap_context(page_snap_context(page));
>>>> -               page->private =3D 0;
>>>> -               ClearPagePrivate(page);
>>>> -               dout("unlocking %d %p\n", i, page);
>>>> -               end_page_writeback(page);
>>>> +               osd_data =3D osd_req_op_extent_osd_data(req, i);
>>>> +               BUG_ON(osd_data->type !=3D CEPH_OSD_DATA_TYPE_PAGE=
S);
>>>> +               num_pages =3D calc_pages_for((u64)osd_data->alignm=
ent,
>>>> +                                          (u64)osd_data->length);
>>>> +               total_pages +=3D num_pages;
>>>> +               for (j =3D 0; j < num_pages; j++) {
>>>> +                       page =3D osd_data->pages[j];
>>>> +                       BUG_ON(!page);
>>>> +                       WARN_ON(!PageUptodate(page));
>>>> +
>>>> +                       if (atomic_long_dec_return(&fsc->writeback=
_count) <
>>>> +                            CONGESTION_OFF_THRESH(
>>>> +                                       fsc->mount_options->conges=
tion_kb))
>>>> +                               clear_bdi_congested(&fsc->backing_=
dev_info,
>>>> +                                                   BLK_RW_ASYNC);
>>>> +
>>>> +                       ceph_put_snap_context(page_snap_context(pa=
ge));
>>>> +                       page->private =3D 0;
>>>> +                       ClearPagePrivate(page);
>>>> +                       dout("unlocking %p\n", page);
>>>> +                       end_page_writeback(page);
>>>> +
>>>> +                       if (remove_page)
>>>> +                               generic_error_remove_page(inode->i=
_mapping,
>>>> +                                                         page);
>>>>=20
>>>> -               /*
>>>> -                * We lost the cache cap, need to truncate the pag=
e before
>>>> -                * it is unlocked, otherwise we'd truncate it late=
r in the
>>>> -                * page truncation thread, possibly losing some da=
ta that
>>>> -                * raced its way in
>>>> -                */
>>>> -               if ((issued & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_L=
AZYIO)) =3D=3D 0)
>>>> -                       generic_error_remove_page(inode->i_mapping=
, page);
>>>> +                       unlock_page(page);
>>>> +               }
>>>> +               dout("writepages_finish %p wrote %llu bytes cleane=
d %d pages\n",
>>>> +                    inode, osd_data->length, rc >=3D 0 ? num_page=
s : 0);
>>>>=20
>>>> -               unlock_page(page);
>>>> +               ceph_release_pages(osd_data->pages, num_pages);
>>>>        }
>>>> -       dout("%p wrote+cleaned %d pages\n", inode, wrote);
>>>> -       ceph_put_wrbuffer_cap_refs(ci, num_pages, snapc);
>>>>=20
>>>> -       ceph_release_pages(osd_data->pages, num_pages);
>>>> +       ceph_put_wrbuffer_cap_refs(ci, total_pages, snapc);
>>>> +
>>>> +       osd_data =3D osd_req_op_extent_osd_data(req, 0);
>>>>        if (osd_data->pages_from_pool)
>>>>                mempool_free(osd_data->pages,
>>>>                             ceph_sb_to_client(inode->i_sb)->wb_pag=
evec_pool);
>>>> @@ -778,17 +778,15 @@ retry:
>>>>        while (!done && index <=3D end) {
>>>>                unsigned i;
>>>>                int first;
>>>> -               pgoff_t next;
>>>> -               int pvec_pages, locked_pages;
>>>> -               struct page **pages =3D NULL;
>>>> +               pgoff_t strip_end =3D 0;
>>>> +               int num_ops =3D 0, max_ops =3D 0;
>>>> +               int pvec_pages, locked_pages =3D 0;
>>>> +               struct page **pages =3D NULL, **data_pages =3D NUL=
L;
>>>>                mempool_t *pool =3D NULL; /* Becomes non-null if me=
mpool used */
>>>>                struct page *page;
>>>>                int want;
>>>> -               u64 offset, len;
>>>> -               long writeback_stat;
>>>> +               u64 offset =3D 0, len =3D 0;
>>>>=20
>>>> -               next =3D 0;
>>>> -               locked_pages =3D 0;
>>>>                max_pages =3D max_pages_ever;
>>>>=20
>>>> get_more_pages:
>>>> @@ -824,8 +822,8 @@ get_more_pages:
>>>>                                unlock_page(page);
>>>>                                break;
>>>>                        }
>>>> -                       if (next && (page->index !=3D next)) {
>>>> -                               dout("not consecutive %p\n", page)=
;
>>>> +                       if (strip_end && (page->index > strip_end)=
) {
>>>> +                               dout("end of strip %p\n", page);
>>>>                                unlock_page(page);
>>>>                                break;
>>>>                        }
>>>> @@ -871,28 +869,60 @@ get_more_pages:
>>>>                         * that it will use.
>>>>                         */
>>>>                        if (locked_pages =3D=3D 0) {
>>>> +                               int j;
>>>>                                BUG_ON(pages);
>>>>                                /* prepare async write request */
>>>>                                offset =3D (u64)page_offset(page);
>>>>                                len =3D wsize;
>>>> -                               req =3D ceph_osdc_new_request(&fsc=
->client->osdc,
>>>> +
>>>> +                               max_ops =3D 1 + do_sync;
>>>> +                               strip_end =3D page->index +
>>>> +                                           ((len - 1) >> PAGE_CAC=
HE_SHIFT);
>>>> +                               for (j =3D i + 1; j < pvec_pages; =
j++) {
>>>> +                                       if (pvec.pages[j]->index >=
 strip_end)
>>>> +                                               break;
>>>> +                                       if (pvec.pages[j]->index -=
 1 !=3D
>>>> +                                           pvec.pages[j - 1]->ind=
ex)
>>>> +                                               max_ops++;
>>>> +                               }
>>>> +
>>>> +                               if (max_ops > CEPH_OSD_INITIAL_OP)=
 {
>>>> +                                       max_ops =3D min(max_ops, C=
EPH_OSD_MAX_OP);
>>>> +                                       req =3D ceph_osdc_new_requ=
est(
>>>> +                                                       &fsc->clie=
nt->osdc,
>>>>                                                        &ci->i_layo=
ut, vino,
>>>> -                                                       offset, &l=
en, 0,
>>>> -                                                       do_sync ? =
2 : 1,
>>>> +                                                       offset, &l=
en,
>>>> +                                                       0, max_ops=
,
>>>> +                                                       CEPH_OSD_O=
P_WRITE,
>>>> +                                                       CEPH_OSD_F=
LAG_WRITE |
>>>> +                                                       CEPH_OSD_F=
LAG_ONDISK,
>>>> +                                                       snapc, tru=
ncate_seq,
>>>> +                                                       truncate_s=
ize, false);
>>>> +                                       if (IS_ERR(req))
>>>> +                                               req =3D NULL;
>>>> +                               }
>>>> +                               if (!req) {
>>>> +                                       max_ops =3D CEPH_OSD_INITI=
AL_OP;
>>>> +                                       req =3D ceph_osdc_new_requ=
est(
>>>> +                                                       &fsc->clie=
nt->osdc,
>>>> +                                                       &ci->i_lay=
out, vino,
>>>> +                                                       offset, &l=
en,
>>>> +                                                       0, max_ops=
,
>>>>                                                        CEPH_OSD_OP=
_WRITE,
>>>>                                                        CEPH_OSD_FL=
AG_WRITE |
>>>>                                                        CEPH_OSD_FL=
AG_ONDISK,
>>>>                                                        snapc, trun=
cate_seq,
>>>>                                                        truncate_si=
ze, true);
>>>> -                               if (IS_ERR(req)) {
>>>> -                                       rc =3D PTR_ERR(req);
>>>> -                                       unlock_page(page);
>>>> -                                       break;
>>>> +                                       if (IS_ERR(req)) {
>>>> +                                               unlock_page(page);
>>>> +                                               rc =3D PTR_ERR(req=
);
>>>> +                                               req =3D NULL;
>>>> +                                               break;
>>>> +                                       }
>>>>                                }
>>>>=20
>>>> -                               if (do_sync)
>>>> -                                       osd_req_op_init(req, 1,
>>>> -                                                       CEPH_OSD_O=
P_STARTSYNC, 0);
>>>> +                               strip_end =3D page->index +
>>>> +                                           ((len - 1) >> PAGE_CAC=
HE_SHIFT);
>>>>=20
>>>>                                req->r_callback =3D writepages_fini=
sh;
>>>>                                req->r_inode =3D inode;
>>>> @@ -905,6 +935,60 @@ get_more_pages:
>>>>                                        pages =3D mempool_alloc(poo=
l, GFP_NOFS);
>>>>                                        BUG_ON(!pages);
>>>>                                }
>>>> +
>>>> +                               num_ops =3D 1;
>>>> +                               data_pages =3D pages;
>>>> +                               len =3D 0;
>>>> +                       } else if (page->index !=3D
>>>> +                                  (offset + len) >> PAGE_CACHE_SH=
IFT) {
>>>> +                               u64 offset_inc;
>>>> +                               bool new_op =3D true;
>>>> +
>>>> +                               if (num_ops + do_sync =3D=3D CEPH_=
OSD_MAX_OP) {
>>>> +                                       new_op =3D false;
>>>> +                               } else if (num_ops + do_sync =3D=3D=
 max_ops) {
>>>> +                                       int new_max =3D max_ops;
>>>> +                                       int j;
>>>> +                                       for (j =3D i + 1; j < pvec=
_pages; j++) {
>>>> +                                               if (pvec.pages[j]-=
>index >
>>>> +                                                   strip_end)
>>>> +                                                       break;
>>>> +                                               if (pvec.pages[j]-=
>index - 1 !=3D
>>>> +                                                   pvec.pages[j -=
 1]->index)
>>>> +                                                       new_max++;
>>>> +                                       }
>>>> +                                       new_max++;
>>>> +                                       new_max =3D min(new_max, C=
EPH_OSD_MAX_OP);
>>>> +                                       if (ceph_osdc_extend_reque=
st(req,
>>>> +                                                               ne=
w_max,
>>>> +                                                               GF=
P_NOFS) >=3D 0)
>>>> +                                               max_ops =3D new_ma=
x;
>>>> +                                       else
>>>> +                                               new_op =3D false;
>>>> +                               }
>>>> +                               if (!new_op) {
>>>> +                                       redirty_page_for_writepage=
(wbc, page);
>>>> +                                       unlock_page(page);
>>>> +                                       break;
>>>> +                               }
>>>> +
>>>> +                               offset_inc =3D (u64)page_offset(pa=
ge) - offset;
>>>> +                               osd_req_op_extent_dup_last(req, of=
fset_inc);
>>>> +
>>>> +                               dout("writepages got pages at %llu=
~%llu\n",
>>>> +                                     offset, len);
>>>> +
>>>> +                               osd_req_op_extent_update(req, num_=
ops - 1, len);
>>>> +                               osd_req_op_extent_osd_data_pages(r=
eq,
>>>> +                                                               nu=
m_ops - 1,
>>>> +                                                               da=
ta_pages,
>>>> +                                                               le=
n, 0,
>>>> +                                                               !!=
pool, false);
>>>> +
>>>> +                               num_ops++;
>>>> +                               data_pages =3D pages + locked_page=
s;
>>>> +                               offset =3D (u64)page_offset(page);
>>>> +                               len =3D 0;
>>>>                        }
>>>>=20
>>>>                        /* note position of first page in pvec */
>>>> @@ -913,9 +997,8 @@ get_more_pages:
>>>>                        dout("%p will write page %p idx %lu\n",
>>>>                             inode, page, page->index);
>>>>=20
>>>> -                       writeback_stat =3D
>>>> -                              atomic_long_inc_return(&fsc->writeb=
ack_count);
>>>> -                       if (writeback_stat > CONGESTION_ON_THRESH(
>>>> +                       if (atomic_long_inc_return(&fsc->writeback=
_count) >
>>>> +                           CONGESTION_ON_THRESH(
>>>>                                    fsc->mount_options->congestion_=
kb)) {
>>>>                                set_bdi_congested(&fsc->backing_dev=
_info,
>>>>                                                  BLK_RW_ASYNC);
>>>> @@ -924,7 +1007,7 @@ get_more_pages:
>>>>                        set_page_writeback(page);
>>>>                        pages[locked_pages] =3D page;
>>>>                        locked_pages++;
>>>> -                       next =3D page->index + 1;
>>>> +                       len +=3D PAGE_CACHE_SIZE;
>>>>                }
>>>>=20
>>>>                /* did we get anything? */
>>>> @@ -952,31 +1035,34 @@ get_more_pages:
>>>>                }
>>>>=20
>>>>                /* Format the osd request message and submit the wr=
ite */
>>>> -               offset =3D page_offset(pages[0]);
>>>> -               len =3D (u64)locked_pages << PAGE_CACHE_SHIFT;
>>>>                if (snap_size =3D=3D -1) {
>>>> +                       /* writepages_finish() clears writeback pa=
ges
>>>> +                        * according to the data length, so make s=
ure
>>>> +                        * data length covers all locked pages */
>>>> +                       u64 min_len =3D len + 1 - PAGE_CACHE_SIZE;
>>>>                        len =3D min(len, (u64)i_size_read(inode) - =
offset);
>>>> -                        /* writepages_finish() clears writeback p=
ages
>>>> -                         * according to the data length, so make =
sure
>>>> -                         * data length covers all locked pages */
>>>> -                       len =3D max(len, 1 +
>>>> -                               ((u64)(locked_pages - 1) << PAGE_C=
ACHE_SHIFT));
>>>> +                       len =3D max(len, min_len);
>>>>                } else {
>>>>                        len =3D min(len, snap_size - offset);
>>>>                }
>>>> -               dout("writepages got %d pages at %llu~%llu\n",
>>>> -                    locked_pages, offset, len);
>>>> +               dout("writepages got pages at %llu~%llu\n", offset=
, len);
>>>>=20
>>>> -               osd_req_op_extent_osd_data_pages(req, 0, pages, le=
n, 0,
>>>> -                                                       !!pool, fa=
lse);
>>>> +               osd_req_op_extent_osd_data_pages(req, num_ops - 1,=
 data_pages,
>>>> +                                                len, 0, !!pool, f=
alse);
>>>> +               osd_req_op_extent_update(req, num_ops - 1, len);
>>>>=20
>>>> +               if (do_sync) {
>>>> +                       osd_req_op_init(req, num_ops, CEPH_OSD_OP_=
STARTSYNC, 0);
>>>> +                       num_ops++;
>>>> +               }
>>>> +               BUG_ON(num_ops > max_ops);
>>>> +
>>>> +               index =3D pages[locked_pages - 1]->index + 1;
>>>>                pages =3D NULL;   /* request message now owns the p=
ages array */
>>>>                pool =3D NULL;
>>>>=20
>>>>                /* Update the write op length in case we changed it=
 */
>>>>=20
>>>> -               osd_req_op_extent_update(req, 0, len);
>>>> -
>>>>                vino =3D ceph_vino(inode);
>>>>                ceph_osdc_build_request(req, offset, snapc, vino.sn=
ap,
>>>>                                        &inode->i_mtime);
>>>> @@ -986,7 +1072,6 @@ get_more_pages:
>>>>                req =3D NULL;
>>>>=20
>>>>                /* continue? */
>>>> -               index =3D next;
>>>>                wbc->nr_to_write -=3D locked_pages;
>>>>                if (wbc->nr_to_write <=3D 0)
>>>>                        done =3D 1;
>>>=20
>>> Hi Zheng,
>>>=20
>>> I know I mentioned off-list that v3 looked good, but I've taken
>>> a deeper look and have to retract that.  This version still has a c=
all
>>> to ceph_osdc_extend_request(), which suggests to me that the number=
 of
>>> ops is calculated incorrectly.
>>>=20
>>> A single op within an OSD request can be used for a single region o=
f
>>> contiguous dirty pages, so what this comes down to is calculating t=
he
>>> number of such dirty contiguous regions.  What you appear to be doi=
ng
>>> in this version is calculating this number for the *first* gang of
>>> pages we get from pagevec_lookup_tag() and allocating an OSD reques=
t
>>> based on that.  If that's not enough (i.e. there are more dirty pag=
es
>>> in the stripe unit), we move on, you do the calculation for the nex=
t
>>> gang and enlange the OSD request by reallocating parts of it.  This
>>> goes on until we either run out of dirty pages in the stripe unit o=
r
>>> reach CEPH_OSD_MAX_OP ops in the request.
>>>=20
>>> What I don't understand is what prevents us from pre-calculating th=
e
>>> number of dirty contiguous regions for the entire stripe unit in on=
e go
>>> and trying to allocate the OSD request based on that number, possib=
ly
>>> falling back to a smaller request if we are short on memory.  The p=
age
>>> pointer array can hold all of pages in the stripe unit - I don't se=
e
>>> the need for ceph_osdc_extend_request() at all.  Am I missing somet=
hing?
>>>=20
>>=20
>> pre-calculating number of regions in the strip unit is ideal for
>> random write, but it impose overhead on the most common sequential
>> write (that's why I don't allocate CEPH_OSD_MAX_OP ops in the first
>> place)  Besides,  pre-calculating number of regions require big
>=20
> Care to be more specific about the overhead?  You have to go through
> enough of dirty pages to either stuff up the OSD request or move past
> the stripe unit no matter which type of write it is.  Allocating
> CEPH_OSD_MAX_OP right off the bat is of course a bad idea, especially
> in the sequential case, but that's not what I'm advocating for.  What
> I'm proposing would result in allocating a request with exactly the
> number of ops needed, in both sequential and random cases - no more, =
no
> less.

Scanning page within a strip unit requires calling pagevec_lookup_tag()=
 multiples times. There are about 1000 pages in the worst case. It mean=
s we need to get/release page 1000 times. In my option, it=E2=80=99s no=
n-trivial overhead.

Regards
Yan, Zheng

> =20
>> modification on both ceph_writepages_start() and
>> ceph_osdc_new_request()  (we don't know where a strip unit end until
>> calling ceph_osdc_new_request()).
>=20
> Well, calling calc_layout() to learn where the first page's stripe un=
it
> ends is trivial enough.  I get your reluctance - ceph_writepages_star=
t()
> is not pleasant to deal with - but in my opinion that's not reason
> enough for reallocating memory in middle of it, possibly more than
> once (!).
>=20
> Thanks,
>=20
>                Ilya

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
