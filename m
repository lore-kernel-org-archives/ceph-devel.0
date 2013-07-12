From: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Subject: HA: wip-libcephfs rebased and pulled up to v.65
Date: Fri, 12 Jul 2013 05:44:01 +0000
Message-ID: <941FC8BE87ADE64D90E4EB6CD554517710023467@EPBYMINSA0032.epam.com>
References: <941FC8BE87ADE64D90E4EB6CD5545177100231F4@EPBYMINSA0032.epam.com>,
 <78k3kyfjv2.wl%aemerson@linuxbox.com>
 <941FC8BE87ADE64D90E4EB6CD554517710023305@EPBYMINSA0032.epam.com>,<alpine.DEB.2.00.1307111201000.5149@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from evbyminsa0038.epam.com ([217.21.63.34]:21403 "EHLO
	EVBYMINSA0038.epam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab3GLFta convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jul 2013 01:49:30 -0400
In-Reply-To: <alpine.DEB.2.00.1307111201000.5149@cobra.newdream.net>
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Adam C. Emerson" <aemerson@linuxbox.com>, "Matt W. Benjamin" <matt@linuxbox.com>, David Zafman <david.zafman@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage, Adam, Matt and David,

this branch is looking good at the first blush. We will check out how i=
t works and report to you till the EOD.

Regards,
Ilya
________________________________________
=EF=D4: Sage Weil [sage@inktank.com]
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 11 =C9=C0=CC=D1 2013 =C7. 23:01
To: Ilya Storozhilov
Cc: Adam C. Emerson; Matt W. Benjamin; David Zafman; ceph-devel@vger.ke=
rnel.org
=F4=C5=CD=C1: Re: wip-libcephfs rebased and pulled up to v.65

Please check out the current wip=3Dlibcephfs branch and let me know how=
 it
looks/works for you guys.  I cleaned up your patches a bit and fixed te=
h
root cause of the xattr issue you were seeing.

Thanks!
sage


On Thu, 11 Jul 2013, Ilya Storozhilov wrote:

> Hi Adam (CC: Sage, Matt and David),
>
> it seems to me we have choosen a bad commit description, where instea=
d of "FIX: readlink not copy link path to user's buffer" there should b=
e something like "FIX: ceph_ll_readlink() now fills user provided buffe=
r with the link data instead of returning a pointer to the libcephfs in=
ternal memory location". Take a look to the sourcecode - it does actual=
ly what you are talking about (see https://github.com/ferustigris/ceph/=
blob/wip-libcephfs-rebased-v65/src/libcephfs.cc):
>
> ---------------------------------------------------------------------=
--
> extern "C" int ceph_ll_readlink(struct ceph_mount_info *cmount, Inode=
 *in, char *buf, size_t bufsiz, int uid, int gid)
> {
>   const char *value =3D NULL;
>   int res =3D (cmount->get_client()->ll_readlink(in, &value, uid, gid=
));
>   if (res < 0)
>     return res;
>   if (bufsiz < (size_t)res)
>     return ENAMETOOLONG;
>   memcpy(buf, value, res);  // <-- Here we are copying a link data to=
 the user provided buffer. This is what you want us to do.
>   return res;
> }
> ---------------------------------------------------------------------=
--
>
> In your branch (see https://github.com/linuxbox2/linuxbox-ceph/blob/w=
ip-libcephfs-rebased-v65/src/libcephfs.cc) this function does not copy =
link data to the user-provided buffer, but passes back a pointer to the=
 internal libcephfs structure, which is not good solution, as you menti=
oned below:
>
> ---------------------------------------------------------------------=
--
> extern "C" int ceph_ll_readlink(struct ceph_mount_info *cmount, Inode=
 *in, char **value, int uid, int gid)
> {
>   return (cmount->get_client()->ll_readlink(in, (const char**) value,=
 uid, gid));
> }
> ---------------------------------------------------------------------=
--
>
> Regards,
> Ilya
>
> ________________________________________
> ??: Adam C. Emerson [aemerson@linuxbox.com]
> ??????????: 10 ???? 2013 ?. 20:41
> To: Ilya Storozhilov
> Cc: Sage Weil; Matt W. Benjamin; David Zafman
> ????: Re: wip-libcephfs rebased and pulled up to v.65
>
> At Wed, 10 Jul 2013 12:17:24 +0000, Ilya Storozhilov wrote:
> [snip]
> > ?wip-libcephfs-rebased-v65? branch of the https://github.com/linuxb=
ox2/linuxbox-ceph repository has not been branched from the ?wip-libcep=
hfs? branch of https://github.com/ceph/ceph as it was made with our ?op=
en_by_handle_api? branch of the https://github.com/ferustigris/ceph rep=
o. That is why we were not able to automatically ?cherry-pick? our chan=
ges using respective git command. So we have manually applied our chang=
es to the ?wip-libcephfs-rebased-v65? branch in https://github.com/feru=
stigris/ceph repo as one commit - you can check it out here: https://gi=
thub.com/ferustigris/ceph/commit/c3f4940b2cfcfd3ea9a004e6f07f1aa3c0b6c4=
19.
> [snip]
>
> Good afternoon, sir.
>
> I was looking at your patch and Matt and I have concerns about the
> change you made to readlink.  By passing back a pointer to a buffer
> rather than copying the link into a supplied buffer, we're opening
> ourselves up to the content changing, being deallocated, or otherwise
> having something bad happen to it.
>
> Thanks.
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
