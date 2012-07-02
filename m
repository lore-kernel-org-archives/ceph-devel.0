From: Gregory Farnum <greg@inktank.com>
Subject: Re: MDS spinning wild after restart on all nodes
Date: Mon, 2 Jul 2012 10:07:32 -0700
Message-ID: <CAPYLRzjW5BGuq0b8prLona3c3+d+kKCQd0MbxGjYcR7c8a7TXQ@mail.gmail.com>
References: <201206151143.25706.a.ott@m-privacy.de>
	<Pine.LNX.4.64.1206150940460.4551@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43447 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab2GBRHe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 13:07:34 -0400
Received: by lbbgm6 with SMTP id gm6so7907772lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 10:07:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206150940460.4551@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

Amon,
I've been going through my backlog of flagged emails and came across
this one. Did you ever get that information for the bug that you were
going to try and find?
-Greg

On Fri, Jun 15, 2012 at 9:44 AM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 15 Jun 2012, Amon Ott wrote:
>> Hello all,
>>
>> I have seen this for a long time, but never investigated further. Af=
ter stable
>> test runs for several days, this is our last known show stopper befo=
re using
>> Ceph in production. We are running 0.47.2 on 32 Bit.
>>
>> If we restart MDS (or all ceph daemons) on all nodes, one after anot=
her or all
>> together, they first recover and then the active one starts to spin =
with full
>> cpu and does not answer any more. After a while, the next takes over=
, starts
>> to spin, etc., until the whole cluster is unusable. This is complete=
ly
>> reproducable and happens even without any active client.
>>
>> As ecpected, ceph -w shows lots of
>> "2012-06-15 11:35:28.588775 =A0 mds e959: 1/1/1 up {0=3D3=3Dup:activ=
e(laggy or
>> crashed)}"
>>
>> It does not help to stop all services on all nodes for minutes or lo=
nger and
>> to restart them - MDS will restart spinning. But: If we reboot the w=
hole
>> cluster, everything goes back to work.
>>
>> Today's MDS log is available at
>> https://download.m-privacy.de/homeuser-mds.0.log.gz
>>
>> Is this a known problem? It has been with us for a looong time now, =
but since
>> rebooting used to help, we never tracked it down.
>
> I haven't seen this before. =A0Can you attach to the spinning process=
 with
> gdb and send us a dump of what the threads are doing? =A0'thread appl=
y all
> bt'. =A0I opened #2596:
>
> =A0 =A0 =A0 =A0 http://tracker.newdream.net/issues/2596
>
> Thanks!
> sage
>
>
>
>
>>
>> Amon Ott
>> --
>> Dr. Amon Ott
>> m-privacy GmbH =A0 =A0 =A0 =A0 =A0 Tel: +49 30 24342334
>> Am K=F6llnischen Park 1 =A0 =A0Fax: +49 30 24342336
>> 10179 Berlin =A0 =A0 =A0 =A0 =A0 =A0 http://www.m-privacy.de
>>
>> Amtsgericht Charlottenburg, HRB 84946
>>
>> Gesch=E4ftsf=FChrer:
>> =A0Dipl.-Kfm. Holger Maczkowsky,
>> =A0Roman Maczkowsky
>>
>> GnuPG-Key-ID: 0x2DD3A649
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
