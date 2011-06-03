From: biyan chen <riby.chen@gmail.com>
Subject: Re: ceph_tool_common_init failed
Date: Fri, 3 Jun 2011 10:24:00 +0800
Message-ID: <BANLkTinitqf3ZDFo_DoPt=9VS6poLqyZcw@mail.gmail.com>
References: <BANLkTinhA3T3F3+ocVrr9vzckJoWZRtXZg@mail.gmail.com>
	<BANLkTimK72kHioovQ=9Jaz0neiBzq+5LNQ@mail.gmail.com>
	<Pine.LNX.4.64.1106020936580.19146@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45802 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab1FCCYC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 22:24:02 -0400
Received: by gxk21 with SMTP id 21so596520gxk.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2011 19:24:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1106020936580.19146@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

I think this is my questions, thank you!


2011/6/3 Sage Weil <sage@newdream.net>:
> On Thu, 2 Jun 2011, Gregory Farnum wrote:
>> 2011/6/2 biyan chen <riby.chen@gmail.com>:
>> > 2011-06-02 16:27:35.010776 7f3f53940720 unable to authenticate as =
client.admin
>>
>> That's your problem. You don't have your keys set up properly to
>> authenticate as the admin on those nodes. :)
>>
>> I suspect permissions problems are the cause of your other issues wi=
th
>> file writing as well. How did you set up this cluster? Try recreatin=
g
>> your cluster by carefully following the instructions at
>> http://ceph.newdream.net/wiki/Creating_a_new_file_system
>
> First you should probably verify that there is a keyring file (usuall=
y
> /etc/ceph/keyring) that has a client.admin key in it (it's plaintext;=
 cat
> it to see) and that it is readable.  It's written to /etc/ceph/keyrin=
g by
> mkcephfs by default but that may have been on a different node, or th=
e
> permissions might be off.  If the file is in a different location, yo=
u can
> explicitly specify that on the command line with '-k path/to/keyring'=
=2E
>
> sage
>



--=20
name:Riby
mobile:+86 15280267642
company: =B0=D9=B4=F3=C1=FA=D2=BB
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
