From: Gregory Meno <gmeno@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_Re=3A_=5Bceph=2Dcalamari=5D_BluePrint=3Aadd_a_rbd_?=
	=?UTF-8?Q?restful_api_for_calamari?=
Date: Wed, 13 Apr 2016 08:32:28 -0400
Message-ID: <CABq-AyQDx7CiaRFpwtuVkjDyhZ9kXAF3JCw5977hiCw+JcYxmw@mail.gmail.com>
References: <OFF87EC0D7.19CDA459-ON48257F8D.003313BC-48257F8D.0033855C@zte.com.cn>
	<5704D708.5030609@redhat.com>
	<OF51BD0D53.54276278-ON48257F8D.00347547-48257F8D.0035C3F1@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34088 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbcDMMc3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 08:32:29 -0400
Received: by mail-yw0-f175.google.com with SMTP id d68so65958791ywe.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 05:32:29 -0700 (PDT)
In-Reply-To: <OF51BD0D53.54276278-ON48257F8D.00347547-48257F8D.0035C3F1@zte.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: song.baisen@zte.com.cn
Cc: Shubhendu Tripathi <shtripat@redhat.com>, Gregory Meno <gregory.meno@inktank.com>, Dan Mick <dmick@redhat.com>, sage@newdream.net, ceph-calamari@ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Apr 6, 2016 at 5:47 AM,  <song.baisen@zte.com.cn> wrote:
> Thank you for your reply!
>
>
> /v2/cluster/fsid/pool_id/rbd(get,post)
>
> Shouldnt this be /v2/cluster/{fsid}/pool/{pool-id}/rbd (get,post)
>
> Yes,Here what i want to say is just as you said.Thank you for your ad=
vice.
>
> 5
> /v2/cluster/{fsid}/pool/{pool_id}/rbd/{imagename}/snapname(get,patch,=
delete)
>
> /v2/cluster/{fsid}/pool/{pool-id}/rbd/{name}/snap (why snapname??)
>
> Here use snapname because there may be a lot of snaps under one image=
=2EAnd
> each
> snap have its own operation.
>
>
>
>
>
>
> Shubhendu Tripathi <shtripat@redhat.com>
>
> 2016-04-06 17:29
>
> =E6=94=B6=E4=BB=B6=E4=BA=BA
> song.baisen@zte.com.cn, gregory.meno@inktank.com, dmick@redhat.com,
> sage@newdream.net,
> =E6=8A=84=E9=80=81
> ceph-calamari@ceph.com, ceph-devel@vger.kernel.org
> =E4=B8=BB=E9=A2=98
> Re: [ceph-calamari] BluePrint:add a rbd restful api for calamari
>
>
>
>
>
> On 04/06/2016 02:52 PM, song.baisen@zte.com.cn wrote:
> Hi, Calamariers and Cephers, nice to meet you all!
>
> Within this email I'd like to share about expanding
> RBD APIs in Python format, which shall be appreciated by Calamari,
> a powerful tool for Ceph management.
>
> Wiki about this BP can be found at the following the link below:
> http://tracker.ceph.com/projects/ceph/wiki/Submissions
> Right now it provides some basic ideas such as motivation=EF=BC=8Cpri=
nciple=EF=BC=8C
> and rough developing plannings only but will get continuous updating
> as the discussion goes on.
>
> At present, Calamari has already introduced a RBD restful APIs
> but those APIs are only available in CLI form and these APIs are
> invisible for Cthulhu.For future consider we should develop rbd restf=
ul
> APIS like pool APIS in calamari.Ceph have provided the rbd python API=
S for
> user to use.We should use the Ceph RBD python APIS better than the CL=
I form.
> The goal of this BP is to make those APIs visible for Cthulhu also,
> and thus we can perform RBD relevant operations through Calamari,
> which shall be much simpler and convenient, especially for future Cal=
amari
> RBD Web dashboard develop.
>
> The following APIs are currently under my consideration, with which
> we can create an image, delete it, create a snap for it, and so on.
> More APIs are on the way!
>
> 1 /v2/cluster/fsid/rbd(get)
>   get: get info of all pools and their containing images.
>
> 2  /v2/cluster/fsid/pool_id/rbd(get,post)
>
> Shouldnt this be /v2/cluster/{fsid}/pool/{pool-id}/rbd (get,post)
>
>   get: get info of a specified pool and its containing images
>   post: mirror image from a specified pool to another
>
> 3 /v2/cluster/fsid/pool_id/rbd/imagename/clone(get post delete)
>
> I feel it should be /v2/cluster/{fsid}/pool/{pool-id}/rbd/{name}/clon=
e
>
>
>   get: get info of a specified image clone
>   post:clone this image from this pool to another pool
>   delete:flatten the clone image in this pool
>
> 4 /v2/cluster/fsid/pool_id/rbd/imagename(get,patch,delete,post)
>
> /v2/cluster/{fsid}/pool/{pool-id}/rbd/{name} (get,patch,delete,post)
>
> Also additional one could be /v2/cluster/{fsid}/pool/{pool-id}/rbd to=
 list
> all the rbds for the pool
>
>   get:get the image detail info
>   patch:update the image name and size and so on.
>   delete: remove this image
>   post: create a snapshot for this image
>
> 5 /v2/cluster/fsid/pool_id/rbd/imagename/snapname(get,patch,delete)
>
> /v2/cluster/{fsid}/pool/{pool-id}/rbd/{name}/snap (why snapname??)
>
>   get:get the detail snap info of this image
>   patch:update the snap info as protect or not and so on.
>   delete:remove this snapshot from the image
>
>
>                                                      Thanks!
>
>
>
>
> --------------------------------------------------------
> ZTE Information Security Notice: The information contained in this ma=
il (and
> any attachment transmitted herewith) is privileged and confidential a=
nd is
> intended for the exclusive use of the addressee(s).  If you are not a=
n
> intended recipient, any disclosure, reproduction, distribution or oth=
er
> dissemination or use of the information contained is strictly prohibi=
ted.
> If you have received this mail in error, please delete it and notify =
us
> immediately.
>
>
>
>
>
> _______________________________________________
> ceph-calamari mailing list
> ceph-calamari@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-calamari-ceph.com
>
>
>
>
> --------------------------------------------------------
> ZTE Information Security Notice: The information contained in this ma=
il (and
> any attachment transmitted herewith) is privileged and confidential a=
nd is
> intended for the exclusive use of the addressee(s).  If you are not a=
n
> intended recipient, any disclosure, reproduction, distribution or oth=
er
> dissemination or use of the information contained is strictly prohibi=
ted.
> If you have received this mail in error, please delete it and notify =
us
> immediately.
>
>


Hello,

Thank for contributing this proposal. I look forward to working with yo=
u!

I have a few questions about the proposed URL structure.
1.  Have you considered that making image name part of the URL would
allow for extraordinarily long URLs?
2.  Would you please share your rationale for putting the image API in
the context of both cluster and pool?
       To me the cluster context makes sense but I'm not sure about
the pool. There is no requirement to keep your images in a specifc
pool. I think that it might be a better experience if pool was a field
on an image. i.e. the list view shows all images in the cluster and
each item mentions what pool it lives in.

cheers,
Gregory
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
