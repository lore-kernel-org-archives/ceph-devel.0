From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: Direct IO on CephFS for blocks larger than 8MB
Date: Sat, 16 Mar 2013 20:38:08 +0800
Message-ID: <CANExM-Oj1ctk5i0HL-7VXd8K3oP5oUTuUWMq-2F5u4i+cHz7Ww@mail.gmail.com>
References: <5A908216FB901F499F602F4F9CEF5B380FEA68C3@SHSMSX102.ccr.corp.intel.com>
	<alpine.DEB.2.00.1303140819420.11175@cobra.newdream.net>
	<F9E1A4A5-FE26-460B-A228-99033A36ECF8@intel.com>
	<alpine.DEB.2.00.1303150931160.23110@cobra.newdream.net>
	<B0E6BFC2-292E-4EB5-BE19-FD0F670EBDE3@enovance.com>
	<869D592D-E098-4EB9-8F25-FC8FBF715E03@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34102 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593Ab3CPMiJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Mar 2013 08:38:09 -0400
Received: by mail-vc0-f174.google.com with SMTP id hx10so1901007vcb.33
        for <ceph-devel@vger.kernel.org>; Sat, 16 Mar 2013 05:38:08 -0700 (PDT)
In-Reply-To: <869D592D-E098-4EB9-8F25-FC8FBF715E03@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Huang, Xiwei" <xiwei.huang@intel.com>
Cc: Sebastien Han <sebastien.han@enovance.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

The following patch should fix the problem.

-Henry

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e51558f..4bcbcb6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -608,7 +608,7 @@ out:
                pos +=3D len;
                written +=3D len;
                left -=3D len;
-               data +=3D written;
+               data +=3D len;
                if (left)
                        goto more;

2013/3/16 Huang, Xiwei <xiwei.huang@intel.com>:
> Yeah. In fact I found the bug report via your blog. Thanks for the sh=
aring. :)
>
> =E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84 iPhone
>
> =E5=9C=A8 2013-3-16=EF=BC=8C8:05=EF=BC=8C"Sebastien Han" <sebastien.h=
an@enovance.com<mailto:sebastien.han@enovance.com>> =E5=86=99=E9=81=93=EF=
=BC=9A
>
> Hi guys,
>
> I imagine we'll see some applications doing large direct IO writes li=
ke this in the HPC space.
>
> I already experienced the bug and actually reported it with Josh also=
 one year ago. The problem was found with CephFS used to store KVM VMs =
disks (running VM). Somehow KVM with the 'no cache' option writes block=
 higher than 8MB.
>
> Cheers.
>
> =E2=80=93=E2=80=93=E2=80=93=E2=80=93
> S=C3=A9bastien Han
> Cloud Engineer
>
> "Always give 100%. Unless you're giving blood."
>
>
>
> <image.png>
>
>
>
>
>
> PHONE : +33 (0)1 49 70 99 72 =E2=80=93 MOBILE : +33 (0)6 52 84 44 70
> EMAIL : sebastien.han@enovance.com<mailto:sebastien.han@enovance.com>=
 =E2=80=93 SKYPE : han.sbastien
> ADDRESS : 10, rue de la Victoire =E2=80=93 75009 Paris
> WEB : www.enovance.com<http://www.enovance.com> =E2=80=93 TWITTER : @=
enovance
>
> On Mar 15, 2013, at 5:33 PM, Sage Weil <sage@inktank.com<mailto:sage@=
inktank.com>> wrote:
>
> On Fri, 15 Mar 2013, Huang, Xiwei wrote:
> ok. Thanks. Is there any documentation for ceph fs client arch as a
> reference if I'd like to look into this?
>
> Not really.
>
> The code you are interested in is fs/ceph/file.c.  The direct io path
> should be pretty clear; it'll build up a list of pages and pass it
> directly to the code in net/ceph/osd_client.c to go out over the wire=
=2E
> Enabling debugging (echo module ceph +p >
> /sys/kernel/debug/dynamic_debug/control, same for module libceph) and
> doing a single large direct-io write should show you where things are
> going wrong.
>
> sage
>
>
>
> ???? iPhone
>
> ? 2013-3-14?23:23?"Sage Weil" <sage@inktank.com<mailto:sage@inktank.c=
om>> ???
>
> On Thu, 14 Mar 2013, Huang, Xiwei wrote:
> Hi, all,
>    I noticed that CephFS fails to support Direct IO for blocks larger=
 than 8MB, say:
>           sudo dd if=3D/dev/zero of=3Dmnt/cephfs/foo bs=3D16M count=3D=
1 oflag=3Ddirect
>           dd: writing `mnt/cephfs/foo: Bad address
>           1+0 records in
>           0+0 records out
>           0 bytes (0 B) copied, 0.213948 s, 0.0 kB/s
>   My version Ceph is 0.56.1.
> ??I also found the bug has been already reported as Bug #2657.
>   Is this fixed in the new 0.58 version?
>
> I'm pretty sure this is a problem on the kernel client side of things=
, not
> the server side (which by default handles writes up to ~100MB or so).=
  I
> suspect it isn't terribly difficult to fix, but hasn't been prioritiz=
ed...
>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org<mailto:majordomo@v=
ger.kernel.org>
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
