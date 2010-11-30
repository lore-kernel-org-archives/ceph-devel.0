From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Tue, 30 Nov 2010 09:07:12 -0800
Message-ID: <AANLkTinkgBwzfESaQNs0VkLn+LGbd8wEccy6LNDSFM2Z@mail.gmail.com>
References: <1291001135.1872.106.camel@cephhost>
	<AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
	<1291085741.1809.25.camel@cephhost>
	<AANLkTikz_quAcoYL8VUoA4i87WczKCh0yM2TsCG6dQEz@mail.gmail.com>
	<1291097975.1809.54.camel@cephhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33852 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab0K3RQm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 12:16:42 -0500
Received: by ewy5 with SMTP id 5so2885417ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Nov 2010 09:16:41 -0800 (PST)
In-Reply-To: <1291097975.1809.54.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>

On Mon, Nov 29, 2010 at 10:19 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> Is "40-50MB/s" the speed that it run bench at local btrfs disk ?
> not the speed that run bench from client to osd server ?
> with this speed ,run bench from client to osd server ,will which =A0g=
et
> about 20~25MB/s( 40~50MB /2 )speed ?
Data on Ceph is replicated across 2 OSDs (by default; this is
configurable). So while figuring out potential performance involves a
lot of variables, in a simple case like this where you aren't bounded
by network bandwidth you'll find that your read/write performance
simply tracks the slower disk. I'd expect your Ceph tests (at least
the streaming ones) to run at 40-50MB/s.

Given that everything else is okay, I cannot stress enough that
running without a journal is going to cause significant performance
degradations. I have a hard time believing that it's responsible for
13-second latencies, but it's possible. So how about you set up a
journal (it can just be a file or new partition on the drives you're
already using) and report back your results after you do that. :)
Adding a journal to the OSDs lets them turn all their random writes
into streaming ones.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
