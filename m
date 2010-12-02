From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Wed, 1 Dec 2010 18:35:11 -0800
Message-ID: <AANLkTikeuWA-MpDAgC3UEx=QsoAMHLzJem87P+X6dWRp@mail.gmail.com>
References: <1291001135.1872.106.camel@cephhost>
	<AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
	<1291085741.1809.25.camel@cephhost>
	<AANLkTikz_quAcoYL8VUoA4i87WczKCh0yM2TsCG6dQEz@mail.gmail.com>
	<1291097975.1809.54.camel@cephhost>
	<AANLkTinkgBwzfESaQNs0VkLn+LGbd8wEccy6LNDSFM2Z@mail.gmail.com>
	<1291167344.1809.60.camel@cephhost>
	<1291186785.1809.91.camel@cephhost>
	<AANLkTinyWUoppSj9QjL+4qBUpKG0Nk5KJZuGN3rv0Vhe@mail.gmail.com>
	<1291253884.1757.10.camel@cephhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36011 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701Ab0LBCfN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Dec 2010 21:35:13 -0500
Received: by ewy5 with SMTP id 5so4017551ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Dec 2010 18:35:12 -0800 (PST)
In-Reply-To: <1291253884.1757.10.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn, Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>

On Wed, Dec 1, 2010 at 5:38 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
>> > and i also detect a issue ,take the following steps:
>> >
>> > $. mckephfs -c ceph.conf -v --mkbtrfs -a
>> > $ =A0init-ceph - ceph.conf --btrfs -v -a start
>> > then execute:
>> > $ =A0init-ceph - ceph.conf --btrfs -v -a stop
>> >
>> > this command can't stop OSD0 and OSD1 cosd process:
>> > OSD0:
>> > /usr/local/bin/cosd -i 0 -c ceph.conf
>> > OSD1:
>> > /usr/local/bin/cosd -i 1 -c ceph.conf
>> Not sure I understand what you're doing here. Also, it looks like
>> you've got a malformed command there -- you don't specify the "-c"
>> option, just the nonexistent "-" option. ;)
>
> Oh,Sorry, i mean that , if i don't create folder "/var/run/ceph" at O=
SD
> hosts manually. Execute the command : "$init-ceph -c ceph.conf --btrf=
s
> -v -a stop " ,which can't auto-kill OSD host cosd process, like this =
:
> OSD0 host:
> $ ps -ef | grep cosd
> root =A0 =A0 13987 =A0 =A0 1 =A00 Dec01 ? =A0 =A0 =A0 =A000:02:55 /us=
r/local/bin/cosd -i 0
> -c ceph.conf
> OSD1 host:
> $ ps -ef | grep cosd
> root =A0 =A0 14028 =A0 =A0 1 =A00 Dec01 ? =A0 =A0 =A0 =A000:02:53 /us=
r/local/bin/cosd -i 1
> -c ceph.conf
>
> I have to execute "kill -9 13987 " and "kill -9 14028" to kill cosd
> process manually, or ,next time , it will fail to execute "$ init-cep=
h
> -c ceph.conf --btrfs -v -a start " command.
Ah. I think that /var/run/ceph is where init-ceph stores the PIDs. It
ought to be created automatically; if it's not we should fix that.
What version of Ceph are you running, and where from? I'd imagine it's
being packaged wrong or something.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
