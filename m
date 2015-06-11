From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: Ceph =?windows-1252?Q?tier=92ing_enhancements_blue_pri?=
 =?windows-1252?Q?nt_for_jewel?=
Date: Thu, 11 Jun 2015 09:42:14 +0800
Message-ID: <5578E776.4020609@ubuntukylin.com>
References: <EA545303A8F8E842820A172C3D641D6E1B0628FD@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:45083 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbbFKBmd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 21:42:33 -0400
In-Reply-To: <EA545303A8F8E842820A172C3D641D6E1B0628FD@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shishir Gowda <Shishir.Gowda@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Just had a quick look, the idea behind it seems to want to give
a flexible, very fine-grained object-level behavior control,
for example, how long an object will stay in a pool.
however, it is not very convincing that whether it worth the
effort to do this fine-grained control, the benefit may not
offset the introduce algorithm overhead

On 2015/6/10 11:11, Shishir Gowda wrote:
> Hi All,
>
> We have uploaded the blueprint for the enhancements we are proposing =
for ceph tier=92ing functionality for Jewel release @
>
> http://tracker.ceph.com/projects/ceph/wiki/Tiering-enhacement
>
> Soliciting comments/feedback for the same.
>
> With regards,
> Shishir
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
