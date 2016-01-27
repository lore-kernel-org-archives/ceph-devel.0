From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH V3 6/6] ceph: scattered page writeback
Date: Wed, 27 Jan 2016 19:00:25 +0800
Message-ID: <A709B78F-3AFA-4BD8-81DE-68762DA6A805@redhat.com>
References: <1453210244-41777-1-git-send-email-zyan@redhat.com> <CAOi1vP-e4wvEXrb2zFSaqew8NEY8P=6gTss-v-gm=aBr68Euow@mail.gmail.com> <CAAM7YAny_uyGQx9m8VzcdNRCOgciabXh-LW2WQG=qAm4DmafGA@mail.gmail.com> <CAOi1vP_bebLHL1ijXG-67vzUTSNbH=T3k1SQU5MypdAL8JZKmQ@mail.gmail.com> <43AC0102-2144-4FE0-95E3-45204009D412@redhat.com> <CAOi1vP-CGaoQbE+1c7eX7kyAYYVneRruBtsrWvE0WLf3meozdA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37557 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbcA0LAj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 06:00:39 -0500
In-Reply-To: <CAOi1vP-CGaoQbE+1c7eX7kyAYYVneRruBtsrWvE0WLf3meozdA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Zheng Yan <ukernel@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>


> On Jan 27, 2016, at 18:45, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> On Wed, Jan 27, 2016 at 10:42 AM, Yan, Zheng <zyan@redhat.com> wrote:
>>=20
>>> On Jan 27, 2016, at 17:29, Ilya Dryomov <idryomov@gmail.com> wrote:
>>>=20
>>> On Wed, Jan 27, 2016 at 2:52 AM, Yan, Zheng <ukernel@gmail.com> wro=
te:
>>>> On Wed, Jan 27, 2016 at 6:15 AM, Ilya Dryomov <idryomov@gmail.com>=
 wrote:
>>>>> On Tue, Jan 19, 2016 at 2:30 PM, Yan, Zheng <zyan@redhat.com> wro=
te:
>>>>>> This patch makes ceph_writepages_start() try using single OSD re=
quest
>>>>>> to write all dirty pages within a strip. When a nonconsecutive d=
irty
>>>>>> page is found, ceph_writepages_start() tries starting a new writ=
e
>>>>>> operation to existing OSD request. If it succeeds, it uses the n=
ew
>>>>>> operation to writeback the dirty page.
>>>>>>=20
>>>>>> Signed-off-by: Yan, Zheng <zyan@redhat.com>
>>>>>> ---
>>>>>> fs/ceph/addr.c | 263 ++++++++++++++++++++++++++++++++++++++-----=
--------------
>>>>>> 1 file changed, 174 insertions(+), 89 deletions(-)
>>>>>>=20
>>>>>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>>>>>> index c222137..ac14d02 100644
>>>>>> --- a/fs/ceph/addr.c
>>>>>> +++ b/fs/ceph/addr.c
>>>>>> @@ -606,71 +606,71 @@ static void writepages_finish(struct ceph_=
osd_request *req,
>>>>>>       struct inode *inode =3D req->r_inode;
>>>>>>       struct ceph_inode_info *ci =3D ceph_inode(inode);
>>>>>>       struct ceph_osd_data *osd_data;
>>>>>> -       unsigned wrote;
>>>>>>       struct page *page;
>>>>>> -       int num_pages;
>>>>>> -       int i;
>>>>>> +       int num_pages, total_pages =3D 0;
>>>>>> +       int i, j;
>>>>>> +       int rc =3D req->r_result;
>>>>>>       struct ceph_snap_context *snapc =3D req->r_snapc;
>>>>>>       struct address_space *mapping =3D inode->i_mapping;
>>>>>> -       int rc =3D req->r_result;
>>>>>> -       u64 bytes =3D req->r_ops[0].extent.length;
>>>>>>       struct ceph_fs_client *fsc =3D ceph_inode_to_client(inode)=
;
>>>>>> -       long writeback_stat;
>>>>>> -       unsigned issued =3D ceph_caps_issued(ci);
>>>>>> +       bool remove_page;
>>>>>>=20
>>>>>> -       osd_data =3D osd_req_op_extent_osd_data(req, 0);
>>>>>> -       BUG_ON(osd_data->type !=3D CEPH_OSD_DATA_TYPE_PAGES);
>>>>>> -       num_pages =3D calc_pages_for((u64)osd_data->alignment,
>>>>>> -                                       (u64)osd_data->length);
>>>>>> -       if (rc >=3D 0) {
>>>>>> -               /*
>>>>>> -                * Assume we wrote the pages we originally sent.=
  The
>>>>>> -                * osd might reply with fewer pages if our write=
back
>>>>>> -                * raced with a truncation and was adjusted at t=
he osd,
>>>>>> -                * so don't believe the reply.
>>>>>> -                */
>>>>>> -               wrote =3D num_pages;
>>>>>> -       } else {
>>>>>> -               wrote =3D 0;
>>>>>> +
>>>>>> +       dout("writepages_finish %p rc %d\n", inode, rc);
>>>>>> +       if (rc < 0)
>>>>>>               mapping_set_error(mapping, rc);
>>>>>> -       }
>>>>>> -       dout("writepages_finish %p rc %d bytes %llu wrote %d (pa=
ges)\n",
>>>>>> -            inode, rc, bytes, wrote);
>>>>>>=20
>>>>>> -       /* clean all pages */
>>>>>> -       for (i =3D 0; i < num_pages; i++) {
>>>>>> -               page =3D osd_data->pages[i];
>>>>>> -               BUG_ON(!page);
>>>>>> -               WARN_ON(!PageUptodate(page));
>>>>>> +       /*
>>>>>> +        * We lost the cache cap, need to truncate the page befo=
re
>>>>>> +        * it is unlocked, otherwise we'd truncate it later in t=
he
>>>>>> +        * page truncation thread, possibly losing some data tha=
t
>>>>>> +        * raced its way in
>>>>>> +        */
>>>>>> +       remove_page =3D !(ceph_caps_issued(ci) &
>>>>>> +                       (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYI=
O));
>>>>>>=20
>>>>>> -               writeback_stat =3D
>>>>>> -                       atomic_long_dec_return(&fsc->writeback_c=
ount);
>>>>>> -               if (writeback_stat <
>>>>>> -                   CONGESTION_OFF_THRESH(fsc->mount_options->co=
ngestion_kb))
>>>>>> -                       clear_bdi_congested(&fsc->backing_dev_in=
fo,
>>>>>> -                                           BLK_RW_ASYNC);
>>>>>> +       /* clean all pages */
>>>>>> +       for (i =3D 0; i < req->r_num_ops; i++) {
>>>>>> +               if (req->r_ops[i].op !=3D CEPH_OSD_OP_WRITE)
>>>>>> +                       break;
>>>>>>=20
>>>>>> -               ceph_put_snap_context(page_snap_context(page));
>>>>>> -               page->private =3D 0;
>>>>>> -               ClearPagePrivate(page);
>>>>>> -               dout("unlocking %d %p\n", i, page);
>>>>>> -               end_page_writeback(page);
>>>>>> +               osd_data =3D osd_req_op_extent_osd_data(req, i);
>>>>>> +               BUG_ON(osd_data->type !=3D CEPH_OSD_DATA_TYPE_PA=
GES);
>>>>>> +               num_pages =3D calc_pages_for((u64)osd_data->alig=
nment,
>>>>>> +                                          (u64)osd_data->length=
);
>>>>>> +               total_pages +=3D num_pages;
>>>>>> +               for (j =3D 0; j < num_pages; j++) {
>>>>>> +                       page =3D osd_data->pages[j];
>>>>>> +                       BUG_ON(!page);
>>>>>> +                       WARN_ON(!PageUptodate(page));
>>>>>> +
>>>>>> +                       if (atomic_long_dec_return(&fsc->writeba=
ck_count) <
>>>>>> +                            CONGESTION_OFF_THRESH(
>>>>>> +                                       fsc->mount_options->cong=
estion_kb))
>>>>>> +                               clear_bdi_congested(&fsc->backin=
g_dev_info,
>>>>>> +                                                   BLK_RW_ASYNC=
);
>>>>>> +
>>>>>> +                       ceph_put_snap_context(page_snap_context(=
page));
>>>>>> +                       page->private =3D 0;
>>>>>> +                       ClearPagePrivate(page);
>>>>>> +                       dout("unlocking %p\n", page);
>>>>>> +                       end_page_writeback(page);
>>>>>> +
>>>>>> +                       if (remove_page)
>>>>>> +                               generic_error_remove_page(inode-=
>i_mapping,
>>>>>> +                                                         page);
>>>>>>=20
>>>>>> -               /*
>>>>>> -                * We lost the cache cap, need to truncate the p=
age before
>>>>>> -                * it is unlocked, otherwise we'd truncate it la=
ter in the
>>>>>> -                * page truncation thread, possibly losing some =
data that
>>>>>> -                * raced its way in
>>>>>> -                */
>>>>>> -               if ((issued & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE=
_LAZYIO)) =3D=3D 0)
>>>>>> -                       generic_error_remove_page(inode->i_mappi=
ng, page);
>>>>>> +                       unlock_page(page);
>>>>>> +               }
>>>>>> +               dout("writepages_finish %p wrote %llu bytes clea=
ned %d pages\n",
>>>>>> +                    inode, osd_data->length, rc >=3D 0 ? num_pa=
ges : 0);
>>>>>>=20
>>>>>> -               unlock_page(page);
>>>>>> +               ceph_release_pages(osd_data->pages, num_pages);
>>>>>>       }
>>>>>> -       dout("%p wrote+cleaned %d pages\n", inode, wrote);
>>>>>> -       ceph_put_wrbuffer_cap_refs(ci, num_pages, snapc);
>>>>>>=20
>>>>>> -       ceph_release_pages(osd_data->pages, num_pages);
>>>>>> +       ceph_put_wrbuffer_cap_refs(ci, total_pages, snapc);
>>>>>> +
>>>>>> +       osd_data =3D osd_req_op_extent_osd_data(req, 0);
>>>>>>       if (osd_data->pages_from_pool)
>>>>>>               mempool_free(osd_data->pages,
>>>>>>                            ceph_sb_to_client(inode->i_sb)->wb_pa=
gevec_pool);
>>>>>> @@ -778,17 +778,15 @@ retry:
>>>>>>       while (!done && index <=3D end) {
>>>>>>               unsigned i;
>>>>>>               int first;
>>>>>> -               pgoff_t next;
>>>>>> -               int pvec_pages, locked_pages;
>>>>>> -               struct page **pages =3D NULL;
>>>>>> +               pgoff_t strip_end =3D 0;
>>>>>> +               int num_ops =3D 0, max_ops =3D 0;
>>>>>> +               int pvec_pages, locked_pages =3D 0;
>>>>>> +               struct page **pages =3D NULL, **data_pages =3D N=
ULL;
>>>>>>               mempool_t *pool =3D NULL; /* Becomes non-null if m=
empool used */
>>>>>>               struct page *page;
>>>>>>               int want;
>>>>>> -               u64 offset, len;
>>>>>> -               long writeback_stat;
>>>>>> +               u64 offset =3D 0, len =3D 0;
>>>>>>=20
>>>>>> -               next =3D 0;
>>>>>> -               locked_pages =3D 0;
>>>>>>               max_pages =3D max_pages_ever;
>>>>>>=20
>>>>>> get_more_pages:
>>>>>> @@ -824,8 +822,8 @@ get_more_pages:
>>>>>>                               unlock_page(page);
>>>>>>                               break;
>>>>>>                       }
>>>>>> -                       if (next && (page->index !=3D next)) {
>>>>>> -                               dout("not consecutive %p\n", pag=
e);
>>>>>> +                       if (strip_end && (page->index > strip_en=
d)) {
>>>>>> +                               dout("end of strip %p\n", page);
>>>>>>                               unlock_page(page);
>>>>>>                               break;
>>>>>>                       }
>>>>>> @@ -871,28 +869,60 @@ get_more_pages:
>>>>>>                        * that it will use.
>>>>>>                        */
>>>>>>                       if (locked_pages =3D=3D 0) {
>>>>>> +                               int j;
>>>>>>                               BUG_ON(pages);
>>>>>>                               /* prepare async write request */
>>>>>>                               offset =3D (u64)page_offset(page);
>>>>>>                               len =3D wsize;
>>>>>> -                               req =3D ceph_osdc_new_request(&f=
sc->client->osdc,
>>>>>> +
>>>>>> +                               max_ops =3D 1 + do_sync;
>>>>>> +                               strip_end =3D page->index +
>>>>>> +                                           ((len - 1) >> PAGE_C=
ACHE_SHIFT);
>>>>>> +                               for (j =3D i + 1; j < pvec_pages=
; j++) {
>>>>>> +                                       if (pvec.pages[j]->index=
 > strip_end)
>>>>>> +                                               break;
>>>>>> +                                       if (pvec.pages[j]->index=
 - 1 !=3D
>>>>>> +                                           pvec.pages[j - 1]->i=
ndex)
>>>>>> +                                               max_ops++;
>>>>>> +                               }
>>>>>> +
>>>>>> +                               if (max_ops > CEPH_OSD_INITIAL_O=
P) {
>>>>>> +                                       max_ops =3D min(max_ops,=
 CEPH_OSD_MAX_OP);
>>>>>> +                                       req =3D ceph_osdc_new_re=
quest(
>>>>>> +                                                       &fsc->cl=
ient->osdc,
>>>>>>                                                       &ci->i_lay=
out, vino,
>>>>>> -                                                       offset, =
&len, 0,
>>>>>> -                                                       do_sync =
? 2 : 1,
>>>>>> +                                                       offset, =
&len,
>>>>>> +                                                       0, max_o=
ps,
>>>>>> +                                                       CEPH_OSD=
_OP_WRITE,
>>>>>> +                                                       CEPH_OSD=
_FLAG_WRITE |
>>>>>> +                                                       CEPH_OSD=
_FLAG_ONDISK,
>>>>>> +                                                       snapc, t=
runcate_seq,
>>>>>> +                                                       truncate=
_size, false);
>>>>>> +                                       if (IS_ERR(req))
>>>>>> +                                               req =3D NULL;
>>>>>> +                               }
>>>>>> +                               if (!req) {
>>>>>> +                                       max_ops =3D CEPH_OSD_INI=
TIAL_OP;
>>>>>> +                                       req =3D ceph_osdc_new_re=
quest(
>>>>>> +                                                       &fsc->cl=
ient->osdc,
>>>>>> +                                                       &ci->i_l=
ayout, vino,
>>>>>> +                                                       offset, =
&len,
>>>>>> +                                                       0, max_o=
ps,
>>>>>>                                                       CEPH_OSD_O=
P_WRITE,
>>>>>>                                                       CEPH_OSD_F=
LAG_WRITE |
>>>>>>                                                       CEPH_OSD_F=
LAG_ONDISK,
>>>>>>                                                       snapc, tru=
ncate_seq,
>>>>>>                                                       truncate_s=
ize, true);
>>>>>> -                               if (IS_ERR(req)) {
>>>>>> -                                       rc =3D PTR_ERR(req);
>>>>>> -                                       unlock_page(page);
>>>>>> -                                       break;
>>>>>> +                                       if (IS_ERR(req)) {
>>>>>> +                                               unlock_page(page=
);
>>>>>> +                                               rc =3D PTR_ERR(r=
eq);
>>>>>> +                                               req =3D NULL;
>>>>>> +                                               break;
>>>>>> +                                       }
>>>>>>                               }
>>>>>>=20
>>>>>> -                               if (do_sync)
>>>>>> -                                       osd_req_op_init(req, 1,
>>>>>> -                                                       CEPH_OSD=
_OP_STARTSYNC, 0);
>>>>>> +                               strip_end =3D page->index +
>>>>>> +                                           ((len - 1) >> PAGE_C=
ACHE_SHIFT);
>>>>>>=20
>>>>>>                               req->r_callback =3D writepages_fin=
ish;
>>>>>>                               req->r_inode =3D inode;
>>>>>> @@ -905,6 +935,60 @@ get_more_pages:
>>>>>>                                       pages =3D mempool_alloc(po=
ol, GFP_NOFS);
>>>>>>                                       BUG_ON(!pages);
>>>>>>                               }
>>>>>> +
>>>>>> +                               num_ops =3D 1;
>>>>>> +                               data_pages =3D pages;
>>>>>> +                               len =3D 0;
>>>>>> +                       } else if (page->index !=3D
>>>>>> +                                  (offset + len) >> PAGE_CACHE_=
SHIFT) {
>>>>>> +                               u64 offset_inc;
>>>>>> +                               bool new_op =3D true;
>>>>>> +
>>>>>> +                               if (num_ops + do_sync =3D=3D CEP=
H_OSD_MAX_OP) {
>>>>>> +                                       new_op =3D false;
>>>>>> +                               } else if (num_ops + do_sync =3D=
=3D max_ops) {
>>>>>> +                                       int new_max =3D max_ops;
>>>>>> +                                       int j;
>>>>>> +                                       for (j =3D i + 1; j < pv=
ec_pages; j++) {
>>>>>> +                                               if (pvec.pages[j=
]->index >
>>>>>> +                                                   strip_end)
>>>>>> +                                                       break;
>>>>>> +                                               if (pvec.pages[j=
]->index - 1 !=3D
>>>>>> +                                                   pvec.pages[j=
 - 1]->index)
>>>>>> +                                                       new_max+=
+;
>>>>>> +                                       }
>>>>>> +                                       new_max++;
>>>>>> +                                       new_max =3D min(new_max,=
 CEPH_OSD_MAX_OP);
>>>>>> +                                       if (ceph_osdc_extend_req=
uest(req,
>>>>>> +                                                               =
new_max,
>>>>>> +                                                               =
GFP_NOFS) >=3D 0)
>>>>>> +                                               max_ops =3D new_=
max;
>>>>>> +                                       else
>>>>>> +                                               new_op =3D false=
;
>>>>>> +                               }
>>>>>> +                               if (!new_op) {
>>>>>> +                                       redirty_page_for_writepa=
ge(wbc, page);
>>>>>> +                                       unlock_page(page);
>>>>>> +                                       break;
>>>>>> +                               }
>>>>>> +
>>>>>> +                               offset_inc =3D (u64)page_offset(=
page) - offset;
>>>>>> +                               osd_req_op_extent_dup_last(req, =
offset_inc);
>>>>>> +
>>>>>> +                               dout("writepages got pages at %l=
lu~%llu\n",
>>>>>> +                                     offset, len);
>>>>>> +
>>>>>> +                               osd_req_op_extent_update(req, nu=
m_ops - 1, len);
>>>>>> +                               osd_req_op_extent_osd_data_pages=
(req,
>>>>>> +                                                               =
num_ops - 1,
>>>>>> +                                                               =
data_pages,
>>>>>> +                                                               =
len, 0,
>>>>>> +                                                               =
!!pool, false);
>>>>>> +
>>>>>> +                               num_ops++;
>>>>>> +                               data_pages =3D pages + locked_pa=
ges;
>>>>>> +                               offset =3D (u64)page_offset(page=
);
>>>>>> +                               len =3D 0;
>>>>>>                       }
>>>>>>=20
>>>>>>                       /* note position of first page in pvec */
>>>>>> @@ -913,9 +997,8 @@ get_more_pages:
>>>>>>                       dout("%p will write page %p idx %lu\n",
>>>>>>                            inode, page, page->index);
>>>>>>=20
>>>>>> -                       writeback_stat =3D
>>>>>> -                              atomic_long_inc_return(&fsc->writ=
eback_count);
>>>>>> -                       if (writeback_stat > CONGESTION_ON_THRES=
H(
>>>>>> +                       if (atomic_long_inc_return(&fsc->writeba=
ck_count) >
>>>>>> +                           CONGESTION_ON_THRESH(
>>>>>>                                   fsc->mount_options->congestion=
_kb)) {
>>>>>>                               set_bdi_congested(&fsc->backing_de=
v_info,
>>>>>>                                                 BLK_RW_ASYNC);
>>>>>> @@ -924,7 +1007,7 @@ get_more_pages:
>>>>>>                       set_page_writeback(page);
>>>>>>                       pages[locked_pages] =3D page;
>>>>>>                       locked_pages++;
>>>>>> -                       next =3D page->index + 1;
>>>>>> +                       len +=3D PAGE_CACHE_SIZE;
>>>>>>               }
>>>>>>=20
>>>>>>               /* did we get anything? */
>>>>>> @@ -952,31 +1035,34 @@ get_more_pages:
>>>>>>               }
>>>>>>=20
>>>>>>               /* Format the osd request message and submit the w=
rite */
>>>>>> -               offset =3D page_offset(pages[0]);
>>>>>> -               len =3D (u64)locked_pages << PAGE_CACHE_SHIFT;
>>>>>>               if (snap_size =3D=3D -1) {
>>>>>> +                       /* writepages_finish() clears writeback =
pages
>>>>>> +                        * according to the data length, so make=
 sure
>>>>>> +                        * data length covers all locked pages *=
/
>>>>>> +                       u64 min_len =3D len + 1 - PAGE_CACHE_SIZ=
E;
>>>>>>                       len =3D min(len, (u64)i_size_read(inode) -=
 offset);
>>>>>> -                        /* writepages_finish() clears writeback=
 pages
>>>>>> -                         * according to the data length, so mak=
e sure
>>>>>> -                         * data length covers all locked pages =
*/
>>>>>> -                       len =3D max(len, 1 +
>>>>>> -                               ((u64)(locked_pages - 1) << PAGE=
_CACHE_SHIFT));
>>>>>> +                       len =3D max(len, min_len);
>>>>>>               } else {
>>>>>>                       len =3D min(len, snap_size - offset);
>>>>>>               }
>>>>>> -               dout("writepages got %d pages at %llu~%llu\n",
>>>>>> -                    locked_pages, offset, len);
>>>>>> +               dout("writepages got pages at %llu~%llu\n", offs=
et, len);
>>>>>>=20
>>>>>> -               osd_req_op_extent_osd_data_pages(req, 0, pages, =
len, 0,
>>>>>> -                                                       !!pool, =
false);
>>>>>> +               osd_req_op_extent_osd_data_pages(req, num_ops - =
1, data_pages,
>>>>>> +                                                len, 0, !!pool,=
 false);
>>>>>> +               osd_req_op_extent_update(req, num_ops - 1, len);
>>>>>>=20
>>>>>> +               if (do_sync) {
>>>>>> +                       osd_req_op_init(req, num_ops, CEPH_OSD_O=
P_STARTSYNC, 0);
>>>>>> +                       num_ops++;
>>>>>> +               }
>>>>>> +               BUG_ON(num_ops > max_ops);
>>>>>> +
>>>>>> +               index =3D pages[locked_pages - 1]->index + 1;
>>>>>>               pages =3D NULL;   /* request message now owns the =
pages array */
>>>>>>               pool =3D NULL;
>>>>>>=20
>>>>>>               /* Update the write op length in case we changed i=
t */
>>>>>>=20
>>>>>> -               osd_req_op_extent_update(req, 0, len);
>>>>>> -
>>>>>>               vino =3D ceph_vino(inode);
>>>>>>               ceph_osdc_build_request(req, offset, snapc, vino.s=
nap,
>>>>>>                                       &inode->i_mtime);
>>>>>> @@ -986,7 +1072,6 @@ get_more_pages:
>>>>>>               req =3D NULL;
>>>>>>=20
>>>>>>               /* continue? */
>>>>>> -               index =3D next;
>>>>>>               wbc->nr_to_write -=3D locked_pages;
>>>>>>               if (wbc->nr_to_write <=3D 0)
>>>>>>                       done =3D 1;
>>>>>=20
>>>>> Hi Zheng,
>>>>>=20
>>>>> I know I mentioned off-list that v3 looked good, but I've taken
>>>>> a deeper look and have to retract that.  This version still has a=
 call
>>>>> to ceph_osdc_extend_request(), which suggests to me that the numb=
er of
>>>>> ops is calculated incorrectly.
>>>>>=20
>>>>> A single op within an OSD request can be used for a single region=
 of
>>>>> contiguous dirty pages, so what this comes down to is calculating=
 the
>>>>> number of such dirty contiguous regions.  What you appear to be d=
oing
>>>>> in this version is calculating this number for the *first* gang o=
f
>>>>> pages we get from pagevec_lookup_tag() and allocating an OSD requ=
est
>>>>> based on that.  If that's not enough (i.e. there are more dirty p=
ages
>>>>> in the stripe unit), we move on, you do the calculation for the n=
ext
>>>>> gang and enlange the OSD request by reallocating parts of it.  Th=
is
>>>>> goes on until we either run out of dirty pages in the stripe unit=
 or
>>>>> reach CEPH_OSD_MAX_OP ops in the request.
>>>>>=20
>>>>> What I don't understand is what prevents us from pre-calculating =
the
>>>>> number of dirty contiguous regions for the entire stripe unit in =
one go
>>>>> and trying to allocate the OSD request based on that number, poss=
ibly
>>>>> falling back to a smaller request if we are short on memory.  The=
 page
>>>>> pointer array can hold all of pages in the stripe unit - I don't =
see
>>>>> the need for ceph_osdc_extend_request() at all.  Am I missing som=
ething?
>>>>>=20
>>>>=20
>>>> pre-calculating number of regions in the strip unit is ideal for
>>>> random write, but it impose overhead on the most common sequential
>>>> write (that's why I don't allocate CEPH_OSD_MAX_OP ops in the firs=
t
>>>> place)  Besides,  pre-calculating number of regions require big
>>>=20
>>> Care to be more specific about the overhead?  You have to go throug=
h
>>> enough of dirty pages to either stuff up the OSD request or move pa=
st
>>> the stripe unit no matter which type of write it is.  Allocating
>>> CEPH_OSD_MAX_OP right off the bat is of course a bad idea, especial=
ly
>>> in the sequential case, but that's not what I'm advocating for.  Wh=
at
>>> I'm proposing would result in allocating a request with exactly the
>>> number of ops needed, in both sequential and random cases - no more=
, no
>>> less.
>>=20
>> Scanning page within a strip unit requires calling pagevec_lookup_ta=
g() multiples times. There are about 1000 pages in the worst case. It m=
eans we need to get/release page 1000 times. In my option, it=E2=80=99s=
 non-trivial overhead.
>=20
> Which page would have to be gotten/released a 1000 times?  We already
> call pagevec_lookup_tag() more than once, until we either move past t=
he
> stripe unit or fill in the OSD request.  Pre-calculating the number o=
f
> dirty regions properly doesn't entail any additional calls to it.  We
> lock the page or release it, it happens once.  Locked pages are stash=
ed
> in the pages page pointer array - is there a reason we can't defer th=
e
> OSD request allocation until after we lock and stash all of the pages
> we are interested in?  Unless I'm misreading the code, the page point=
er
> array is always big enough to accommodate.

Make sense, I will update my patches

Regards
Yan, Zheng

>=20
> Thanks,
>=20
>                Ilya

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
