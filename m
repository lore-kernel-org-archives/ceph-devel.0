From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: librados2 and librbd1 dependency on libvirt-bin
Date: Wed, 25 Feb 2015 15:40:52 -0800
Message-ID: <CACkq2mrYW7V0apw1e5TnfuryJg9qDdbZDkHKzJA_Sp5Y2VGwag@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAC5F@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1502251516270.25838@cobra.newdream.net> <CACkq2mqf-aBBOuWwDVhXU4U1tsQdqLLQqr5Yxet9T=YdJXYHXw@mail.gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAD2A@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:38501 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbbBYXlO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 18:41:14 -0500
Received: by lamq1 with SMTP id q1so7505817lam.5
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 15:41:13 -0800 (PST)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAD2A@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

So just to clarify a bit...

> So, I am curious why libvirt-bin has a depencey on librados2/librbd1 =
?
I think Sage hit this already.  libvirt-bin links against these so
that it can talk to Ceph.

> Also, how come we get rid of this issue ?
> Ceph-deploy should not remove any package other than ceph's
Agreed - it shouldn't be.  You are saying that you did "ceph-deploy
purge" and it not only uninstalled librados2 and librbd1, but
libvirt-bin as well?

I can try to recreate this.

You are running Ubuntu Trusty?

what version of ceph-deploy?  (ceph-deploy --version)

On Wed, Feb 25, 2015 at 3:33 PM, Somnath Roy <Somnath.Roy@sandisk.com> =
wrote:
> We did =E2=80=98ceph-deploy purge <host-name>=E2=80=99
> According to the following link
> http://ceph.com/docs/master/rados/deployment/ceph-deploy-purge/
>
> -----Original Message-----
> From: Travis Rhoden [mailto:trhoden@gmail.com]
> Sent: Wednesday, February 25, 2015 3:32 PM
> To: Sage Weil
> Cc: Somnath Roy; Ceph Development
> Subject: Re: librados2 and librbd1 dependency on libvirt-bin
>
> <sorry to sage and somnath for double-post -- ceph-devel got me with =
plain text again.  :) >
>
> On Debian/Ubuntu, the uninstall/purge will remove the following packa=
ges:
>
> ceph
> ceph-mds
> ceph-common
> ceph-fs-common.
>
> Ironically, ceph-deploy will spit out on the CLI that it does *not* r=
emove librados2 and librbd1, because yes that would break qemu/libvirt.=
  The intent is to leave those libraries.
>
> I wonder if something has changed along these lies.  those libraries =
should have stayed on the host.
>
> So I am curious what ceph-deploy command you actually ran.
> ceph-deploy should not be able to uninstall librados2 or librbd1, but=
 you mentioned that you purged them.  How?  Was it through ceph-deploy?
>
> On Wed, Feb 25, 2015 at 3:21 PM, Sage Weil <sage@newdream.net> wrote:
>> On Wed, 25 Feb 2015, Somnath Roy wrote:
>>> Hi,
>>> We are facing problem that ceph-deploy purge is uninstalling latest=
 Mellanox ofed driver packages.
>>> Digging down more we found libvirt-bin is dependent on librados2/li=
brbd1.
>>> So, here is what happening.
>>>
>>> 1. Mellanox ofed driver has a dependency on the libvirt-bin*
>>>
>>> 2. purging librados2/librbd1 is removing libvirt-bin and resulting =
the removal of the Mellanox driver package as well.
>>>
>>> Here is what I found.
>>>
>>> http://packages.ubuntu.com/trusty/devel/libvirt-bin
>>>
>>> ubuntu@ip-10-15-16-211:~$ apt-cache rdepends librados2 [...]
>>
>> The problem is that libvirt (and probably qemu) are built against li=
brbd1.
>> If you remove librbd1, those get removed too.
>>
>>> So, I am curious why libvirt-bin has a depencey on librados2/librbd=
1 ?
>>
>> qemu needs it for obvious reasons.  libvirt needs it to manage it's
>> (rbd) storage pools.
>>
>>> Also, how come we get rid of this issue ?
>>> Ceph-deploy should not remove any package other than ceph's.
>>
>> Purge could skip the libraries that may have other dependencies, but
>> then it's a purge-lite.  Honestly I thought it skipped them for that
>> reason but we probably changed it at some point because it (also
>> confusingly) wouldn't remove librados etc...
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
