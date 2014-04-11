From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] rbd: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Fri, 11 Apr 2014 08:17:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404110817110.16913@cobra.newdream.net>
References: <1397205492-24447-1-git-send-email-duanj.fnst@cn.fujitsu.com> <CAAM7YA=CwbM8Hgh+QFMoGP1RLaA1drwabG_O2sOqCOcg_Wv+fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YA=CwbM8Hgh+QFMoGP1RLaA1drwabG_O2sOqCOcg_Wv+fg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Duan Jiong <duanj.fnst@cn.fujitsu.com>, yehuda@inktank.com, elder@kernel.org, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Applied, thanks!

sage

On Fri, 11 Apr 2014, Yan, Zheng wrote:

> On Fri, Apr 11, 2014 at 4:38 PM, Duan Jiong <duanj.fnst@cn.fujitsu.com> wrote:
> > This patch fixes coccinelle error regarding usage of IS_ERR and
> > PTR_ERR instead of PTR_ERR_OR_ZERO.
> >
> > Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
> > ---
> >  drivers/block/rbd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index 4c95b50..552a2ed 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -4752,7 +4752,7 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
> >
> >                 image_id = ceph_extract_encoded_string(&p, p + ret,
> >                                                 NULL, GFP_NOIO);
> > -               ret = IS_ERR(image_id) ? PTR_ERR(image_id) : 0;
> > +               ret = PTR_ERR_OR_ZERO(image_id);
> >                 if (!ret)
> >                         rbd_dev->image_format = 2;
> >         } else {
> 
> Reviewed-by: Yan, Zheng <zheng.z.yan@intel.com>
> 
> > --
> > 1.8.3.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
