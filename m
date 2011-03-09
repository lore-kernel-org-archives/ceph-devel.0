From: Upendra Moturi <upendra.m@hexagrid.com>
Subject: Re: Issue with replication level.
Date: Wed, 9 Mar 2011 16:28:35 +0530
Message-ID: <AANLkTinsabAgrAhKenScJah7q0x9RGvWNQx1HO2=kKFo@mail.gmail.com>
References: <AANLkTin_M1Bx878=Avkm5+p1mhvJoYg1R87xjZSc4e=b@mail.gmail.com>
	<29A2C5787D4B4B568C3DC53A800E687C@gmail.com>
	<AANLkTim_wDvKGQjfQohoogWD1GTKd_HYM7mqQFxRXoh1@mail.gmail.com>
	<9C537FF0F9E84D67AA8CCD2D1560B8D4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49692 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab1CILBP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2011 06:01:15 -0500
Received: by bwz15 with SMTP id 15so552153bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2011 03:01:14 -0800 (PST)
In-Reply-To: <9C537FF0F9E84D67AA8CCD2D1560B8D4@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>, Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>, Saurav Lahiri <saurav.lahiri@hexagrid.com>

Thank you Brian Chrisman and Gregory Farnum for help.
I understood the concept and able to figure out and fix it by
separating journal from data volume.(having a separate partition for
journal)

On Tue, Mar 8, 2011 at 11:49 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Tuesday, March 8, 2011 at 10:09 AM, Brian Chrisman wrote:
> Just making sure I'm interpreting this right.
>> At steady state (data_size >> journal_size), total space usage for 2x
>> replication should be 2 * data_size + journal_size?
>> If you have (data_size < journal_size) and journal is on a file rather
>> than on a partition, then btrfs will report 4x data size.
>
> Steady state should be 2 * data_size + journal_size*num_osds -- assuming all your OSDs have the same size journal, anyway! :)
> I'm not sure how the journal grows as a file before it reaches maximum size -- either it starts out as max size (same formula as above), or else it grows as data is written in, yielding for (data_size < journal_size) used_size = data_size * 4.
>
> Though this obscures the impact of, eg, the metadata -- which will get written to both the MDS journal (stored on OSDs) and to the inodes (in the metadata pool, on OSDs).
> -Greg
>
>
>
>



-- 
Thanks and Regards,
Upendra.M
