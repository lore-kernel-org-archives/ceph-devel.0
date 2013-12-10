From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: [PATCH 1/2] No MDS mount error fix
Date: Tue, 10 Dec 2013 09:25:22 +0800
Message-ID: <52A66D82.3070001@ubuntukylin.com>
References: <1b8c4b9c49deb956e9d065b0677bfeaf17c968d2.1386442053.git.plageat90@gmail.com>	<52A5D324.7010604@ubuntukylin.com> <CAN6N2SYZXgAKhu2mdBBr0=j2Dyry4Apr2EK0iMuCJiaK9_FczA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:42064 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab3LJBZ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Dec 2013 20:25:27 -0500
In-Reply-To: <CAN6N2SYZXgAKhu2mdBBr0=j2Dyry4Apr2EK0iMuCJiaK9_FczA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?0JzQuNGF0LDRgdGMINCa0LDQvNC/0L7RgQ==?= <plageat90@gmail.com>
Cc: ceph-devel@vger.kernel.org

Then we have to make a choice between immediately returning with error=20
and patiently waiting for mds joining. My suggestion is
(1) Leave an error message from the kernel using 'printk(KERN_WARN"no=20
active mds")' something in __choose_mds()
(2) Add a return value 'E_WAITING_FOR_MAP' to __choose_mds(), and=20
capture it in ceph_mdsc_do_request(), if the user feel boring to CRTL+C=
=20
to kill the mount process (user should at least know how to interrupt=20
the mount :) ), then ceph_mdsc_do_request() know that it is interrupted=
=20
while waiting for new map, then return good error message to user.

On 2013/12/9 22:50, =D0=9C=D0=B8=D1=85=D0=B0=D1=81=D1=8C =D0=9A=D0=B0=D0=
=BC=D0=BF=D0=BE=D1=81 wrote:
> I agree with some points. But this patches originally created to fix
> "confusing for new users for hard-understandable return messages" (ba=
sed
> on http://tracker.ceph.com/issues/4386). The idea was to return a
> different error code, which can be than handled by ceph.mount client =
for
> printing simple message about "what's going on".
>
>
> 2013/12/9 Li Wang <liwang@ubuntukylin.com <mailto:liwang@ubuntukylin.=
com>>
>
>     Personally, I don't think there is issue for current implementati=
on,
>     either. If no ACTIVE mds, the mount process put to wait, until
>     updated MDS map received and with active mds present indicated in
>     the map, it will be waked up and go on the mount process, otherwi=
se,
>     EIO returned if timeout. If it is boring to hang for a long time,
>     you can specify a shorter mount timeout.
>
>
>     On 2013/12/8 2:59, Mikhail Campos Guadamuz wrote:
>
>         For http://tracker.ceph.com/__issues/4386
>         <http://tracker.ceph.com/issues/4386>
>
>         It determines situation, when a user is trying to mount CephF=
S
>         with no MDS present. Return ECOMM from
>         open_root_dentry which can be analyzed then by ceph.mount
>
>         Signed-off-by: Mikhail Campos Guadamuz <plageat90@gmail.com
>         <mailto:plageat90@gmail.com>>
>         ---
>            fs/ceph/mdsmap.c            | 19 ++++++++++++++++---
>            fs/ceph/super.c             | 10 +++++++++-
>            include/linux/ceph/mdsmap.h |  1 +
>            3 files changed, 26 insertions(+), 4 deletions(-)
>
>         diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
>         index 132b64e..3a6ba8a 100644
>         --- a/fs/ceph/mdsmap.c
>         +++ b/fs/ceph/mdsmap.c
>         @@ -12,6 +12,20 @@
>
>            #include "super.h"
>
>         +/*
>         + * count active mds's
>         + */
>         +int ceph_mdsmap_active_mds_count(__struct ceph_mdsmap *m)
>         +{
>         +    int n =3D 0;
>         +    int i;
>         +
>         +    for(i =3D 0; i < m->m_max_mds; ++i)
>         +       if(m->m_info[i].state > 0)
>         +           ++n;
>         +
>         +    return  n;
>         +}
>
>            /*
>             * choose a random mds that is "up" (i.e. has a state > 0)=
,
>         or -1.
>         @@ -26,9 +40,8 @@ int ceph_mdsmap_get_random_mds(__struct
>         ceph_mdsmap *m)
>                          return 0;
>
>                  /* count */
>         -       for (i =3D 0; i < m->m_max_mds; i++)
>         -               if (m->m_info[i].state > 0)
>         -                       n++;
>         +       n =3D ceph_mdsmap_active_mds_count(__m);
>         +
>                  if (n =3D=3D 0)
>                          return -1;
>
>         diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>         index 6627b26..4d33d68 100644
>         --- a/fs/ceph/super.c
>         +++ b/fs/ceph/super.c
>         @@ -674,7 +674,15 @@ static struct dentry
>         *open_root_dentry(struct ceph_fs_client *fsc,
>                  struct ceph_mds_request *req =3D NULL;
>                  int err;
>                  struct dentry *root;
>         -
>         +
>         +       /* check for mds*/
>         +       if( 0 =3D=3D ceph_mdsmap_active_mds_count(__mdsc->mds=
map) )
>         +       {
>         +           pr_info("active mds not found, possible not exist=
\n");
>         +           root =3D ERR_PTR( -ECOMM );
>         +           return root;
>         +       }
>         +
>                  /* open dir */
>                  dout("open_root_inode opening '%s'\n", path);
>                  req =3D ceph_mdsc_create_request(mdsc,
>         CEPH_MDS_OP_GETATTR, USE_ANY_MDS);
>         diff --git a/include/linux/ceph/mdsmap.h
>         b/include/linux/ceph/mdsmap.h
>         index 87ed09f..4d7d502 100644
>         --- a/include/linux/ceph/mdsmap.h
>         +++ b/include/linux/ceph/mdsmap.h
>         @@ -56,6 +56,7 @@ static inline bool ceph_mdsmap_is_laggy(str=
uct
>         ceph_mdsmap *m, int w)
>                  return false;
>            }
>
>         +extern int ceph_mdsmap_active_mds_count(__struct ceph_mdsmap=
 *m);
>            extern int ceph_mdsmap_get_random_mds(__struct ceph_mdsmap=
 *m);
>            extern struct ceph_mdsmap *ceph_mdsmap_decode(void **p, vo=
id
>         *end);
>            extern void ceph_mdsmap_destroy(struct ceph_mdsmap *m);
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
