From: Yanhu Cao <gmayyyha@gmail.com>
Subject: Re: [PATCH] ceph: if we are blacklisted, __do_request returns directly
Date: Fri, 17 Apr 2020 17:18:29 +0800
Message-ID: <CAB9OAC2VvwM5+L=N09Y-usxyXFRnzWFs8iN-zLHyEz7-twPOmQ@mail.gmail.com>
References: <20200417083448.9122-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200417083448.9122-1-gmayyyha@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

DNM. will add test mount option recover_session.

On Fri, Apr 17, 2020 at 4:35 PM Yanhu Cao <gmayyyha@gmail.com> wrote:
>
> Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> ---
>  fs/ceph/mds_client.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 486f91f9685b..d2ea755b7c02 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2708,6 +2708,11 @@ static void __do_request(struct ceph_mds_client *mdsc,
>
>         put_request_session(req);
>
> +       if (mdsc->fsc->blacklisted) {
> +               err = -EACCES;
> +               goto finish;
> +       }
> +
>         mds = __choose_mds(mdsc, req, &random);
>         if (mds < 0 ||
>             ceph_mdsmap_get_state(mdsc->mdsmap, mds) < CEPH_MDS_STATE_ACTIVE) {
> --
> 2.24.2 (Apple Git-127)
>
