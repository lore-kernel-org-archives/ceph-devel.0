From: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Failed to repair pg
Date: Fri, 8 Mar 2019 09:18:45 +1000
Message-ID: <CAF-wwdEo8U0vK_331utUpvC1o9C=oChiaO6cqsdnco6TVkDsRw@mail.gmail.com>
References: <20190307163755.GV6574@registro.br>
 <20190307173242.GB6574@registro.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20190307173242.GB6574-b2jWxOBV4z0IdKJ7tpkyPg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Herbert Alexander Faleiros <herbert-b2jWxOBV4z0IdKJ7tpkyPg@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

you could try reading the data from this object and write it again
using rados get then rados put.

On Fri, Mar 8, 2019 at 3:32 AM Herbert Alexander Faleiros
<herbert-b2jWxOBV4z0IdKJ7tpkyPg@public.gmane.org> wrote:
>
> On Thu, Mar 07, 2019 at 01:37:55PM -0300, Herbert Alexander Faleiros wrote:
> > Hi,
> >
> > # ceph health detail
> > HEALTH_ERR 3 scrub errors; Possible data damage: 1 pg inconsistent
> > OSD_SCRUB_ERRORS 3 scrub errors
> > PG_DAMAGED Possible data damage: 1 pg inconsistent
> >     pg 2.2bb is active+clean+inconsistent, acting [36,12,80]
> >
> > # ceph pg repair 2.2bb
> > instructing pg 2.2bb on osd.36 to repair
> >
> > But:
> >
> > 2019-03-07 13:23:38.636881 [ERR]  Health check update: Possible data damage: 1 pg inconsistent, 1 pg repair (PG_DAMAGED)
> > 2019-03-07 13:20:38.373431 [ERR]  2.2bb deep-scrub 3 errors
> > 2019-03-07 13:20:38.373426 [ERR]  2.2bb deep-scrub 0 missing, 1 inconsistent objects
> > 2019-03-07 13:20:43.486860 [ERR]  Health check update: 3 scrub errors (OSD_SCRUB_ERRORS)
> > 2019-03-07 13:19:17.741350 [ERR]  deep-scrub 2.2bb 2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986 : is an unexpected clone
> > 2019-03-07 13:19:17.523042 [ERR]  2.2bb shard 36 soid 2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986 : data_digest 0xffffffff != data_digest 0xfc6b9538 from shard 12, size 0 != size 4194304 from auth oi 2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986(482757'14986708 client.112595650.0:344888465 dirty|omap_digest s 4194304 uv 14974021 od ffffffff alloc_hint [0 0 0]), size 0 != size 4194304 from shard 12
> > 2019-03-07 13:19:17.523038 [ERR]  2.2bb shard 36 soid 2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986 : candidate size 0 info size 4194304 mismatch
> > 2019-03-07 13:16:48.542673 [ERR]  2.2bb repair 2 errors, 1 fixed
> > 2019-03-07 13:16:48.542656 [ERR]  2.2bb repair 1 missing, 0 inconsistent objects
> > 2019-03-07 13:16:53.774956 [ERR]  Health check update: Possible data damage: 1 pg inconsistent (PG_DAMAGED)
> > 2019-03-07 13:16:53.774916 [ERR]  Health check update: 2 scrub errors (OSD_SCRUB_ERRORS)
> > 2019-03-07 13:15:16.986872 [ERR]  repair 2.2bb 2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986 : is an unexpected clone
> > 2019-03-07 13:15:16.986817 [ERR]  2.2bb shard 36 2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986 : missing
> > 2019-03-07 13:12:18.517442 [ERR]  Health check update: Possible data damage: 1 pg inconsistent, 1 pg repair (PG_DAMAGED)
> >
> > Also tried deep-scrub and scrub, same results.
> >
> > Also set noscrub,nodeep-scrub, kicked currently active scrubs one at
> > a time using 'ceph osd down <id>'. After the last scrub was kicked,
> > forced scrub ran immediately then 'ceph pg repair', no luck.
> >
> > Finally tryed the manual aproach:
> >
> >  - stop osd.36
> >  - flush-journal
> >  - rm rbd\udata.dfd5e2235befd0.000000000001c299__4f986_CBDE52BB__2
> >  - start osd.36
> >  - ceph pg repair 2.2bb
> >
> > Also no luck...
> >
> > rbd\udata.dfd5e2235befd0.000000000001c299__4f986_CBDE52BB__2 at osd.36
> > is empty (0 size). At osd.80 4.0M, osd.2 is bluestore (can't find it).
> >
> > Ceph is 12.2.10, I'm currently migrating all my OSDs to bluestore.
> >
> > Is there anything else I can do?
>
> Should I do something like this? (below, after stop osd.36)
>
> # ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-36/ --journal-path /dev/sdc1 rbd_data.dfd5e2235befd0.000000000001c299 remove-clone-metadata 326022
>
> I'm no sure about rbd_data.$RBD and $CLONEID (took from rados
> list-inconsistent-obj, also below).
>
> > # rados list-inconsistent-obj 2.2bb | jq
> > {
> >   "epoch": 484655,
> >   "inconsistents": [
> >     {
> >       "object": {
> >         "name": "rbd_data.dfd5e2235befd0.000000000001c299",
> >         "nspace": "",
> >         "locator": "",
> >         "snap": 326022,
> >         "version": 14974021
> >       },
> >       "errors": [
> >         "data_digest_mismatch",
> >         "size_mismatch"
> >       ],
> >       "union_shard_errors": [
> >         "size_mismatch_info",
> >         "obj_size_info_mismatch"
> >       ],
> >       "selected_object_info": {
> >         "oid": {
> >           "oid": "rbd_data.dfd5e2235befd0.000000000001c299",
> >           "key": "",
> >           "snapid": 326022,
> >           "hash": 3420345019,
> >           "max": 0,
> >           "pool": 2,
> >           "namespace": ""
> >         },
> >         "version": "482757'14986708",
> >         "prior_version": "482697'14980304",
> >         "last_reqid": "client.112595650.0:344888465",
> >         "user_version": 14974021,
> >         "size": 4194304,
> >         "mtime": "2019-03-02 22:30:23.812849",
> >         "local_mtime": "2019-03-02 22:30:23.813281",
> >         "lost": 0,
> >         "flags": [
> >           "dirty",
> >           "omap_digest"
> >         ],
> >         "legacy_snaps": [],
> >         "truncate_seq": 0,
> >         "truncate_size": 0,
> >         "data_digest": "0xffffffff",
> >         "omap_digest": "0xffffffff",
> >         "expected_object_size": 0,
> >         "expected_write_size": 0,
> >         "alloc_hint_flags": 0,
> >         "manifest": {
> >           "type": 0,
> >           "redirect_target": {
> >             "oid": "",
> >             "key": "",
> >             "snapid": 0,
> >             "hash": 0,
> >             "max": 0,
> >             "pool": -9223372036854776000,
> >             "namespace": ""
> >           }
> >         },
> >         "watchers": {}
> >       },
> >       "shards": [
> >         {
> >           "osd": 12,
> >           "primary": false,
> >           "errors": [],
> >           "size": 4194304,
> >           "omap_digest": "0xffffffff",
> >           "data_digest": "0xfc6b9538"
> >         },
> >         {
> >           "osd": 36,
> >           "primary": true,
> >           "errors": [
> >             "size_mismatch_info",
> >             "obj_size_info_mismatch"
> >           ],
> >           "size": 0,
> >           "omap_digest": "0xffffffff",
> >           "data_digest": "0xffffffff",
> >           "object_info": {
> >             "oid": {
> >               "oid": "rbd_data.dfd5e2235befd0.000000000001c299",
> >               "key": "",
> >               "snapid": 326022,
> >               "hash": 3420345019,
> >               "max": 0,
> >               "pool": 2,
> >               "namespace": ""
> >             },
> >             "version": "482757'14986708",
> >             "prior_version": "482697'14980304",
> >             "last_reqid": "client.112595650.0:344888465",
> >             "user_version": 14974021,
> >             "size": 4194304,
> >             "mtime": "2019-03-02 22:30:23.812849",
> >             "local_mtime": "2019-03-02 22:30:23.813281",
> >             "lost": 0,
> >             "flags": [
> >               "dirty",
> >               "omap_digest"
> >             ],
> >             "legacy_snaps": [],
> >             "truncate_seq": 0,
> >             "truncate_size": 0,
> >             "data_digest": "0xffffffff",
> >             "omap_digest": "0xffffffff",
> >             "expected_object_size": 0,
> >             "expected_write_size": 0,
> >             "alloc_hint_flags": 0,
> >             "manifest": {
> >               "type": 0,
> >               "redirect_target": {
> >                 "oid": "",
> >                 "key": "",
> >                 "snapid": 0,
> >                 "hash": 0,
> >                 "max": 0,
> >                 "pool": -9223372036854776000,
> >                 "namespace": ""
> >               }
> >             },
> >             "watchers": {}
> >           }
> >         },
> >         {
> >           "osd": 80,
> >           "primary": false,
> >           "errors": [],
> >           "size": 4194304,
> >           "omap_digest": "0xffffffff",
> >           "data_digest": "0xfc6b9538"
> >         }
> >       ]
> >     }
> >   ]
> > }
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Cheers,
Brad
