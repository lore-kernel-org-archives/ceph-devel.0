From: Gregory Farnum <greg@inktank.com>
Subject: Re: maintanance on osd host
Date: Tue, 26 Feb 2013 12:27:32 -0800
Message-ID: <CAPYLRzi+Mrcyp-Nd8C-hqBWfUAvSCNOYY8PE9Po7uPfPTcS9EQ@mail.gmail.com>
References: <512CCD19.7010509@profihost.ag>
	<alpine.DEB.2.00.1302260904440.2730@cobra.newdream.net>
	<727CEF0E-7D1E-4298-B0E4-9729CAA4E787@profihost.ag>
	<alpine.DEB.2.00.1302260922510.4819@cobra.newdream.net>
	<512D10AA.2020906@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:53934 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab3BZU1e convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 15:27:34 -0500
Received: by mail-wi0-f173.google.com with SMTP id hq4so5394869wib.12
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 12:27:33 -0800 (PST)
In-Reply-To: <512D10AA.2020906@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 26, 2013 at 11:44 AM, Stefan Priebe <s.priebe@profihost.ag>=
 wrote:
> Hi Sage,
>
> Am 26.02.2013 18:24, schrieb Sage Weil:
>
>> On Tue, 26 Feb 2013, Stefan Priebe - Profihost AG wrote:
>>>
>>> But that redults in a 1-3s hickup for all KVM vms. This is not what=
 I
>>> want.
>>
>>
>> You can do
>>
>>   kill $pid
>>   ceph osd down $osdid
>>
>> (or even reverse the order, if the sequence is quick enough) to avoi=
d
>> waiting for the failure detection delay.  But if the OSDs are going =
down,
>> then the peering has to happen one way or another.
>
>
> But exaclty this results in starting backfill immediatly. My idea was=
 to
> first mark the osd down so the mon knows about this fact. So no I/O i=
s
> stalled. And then reboot the whole host but exactly this does not wor=
k like
> expected as backfilling is starting immediatly after setting the osd =
to down
> ;-(

"out" and "down" are quite different =97 are you sure you tried "down"
and not "out"? (You reference out in your first email, rather than
down.)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
