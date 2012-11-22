From: hemant surale <hemant.surale@gmail.com>
Subject: Re: OSD daemon changes port no
Date: Thu, 22 Nov 2012 13:08:47 +0530
Message-ID: <CAGfy=6kUHn7Sjp4dBBR1SFVv67X9R2CpWCOZ6NmMtkR2dVmkKQ@mail.gmail.com>
References: <CAGfy=6kVyt-a+j8mKYqXYVErRWEUK8ko1ydJuBxY5dr849OD0A@mail.gmail.com>
	<alpine.DEB.2.00.1211200844240.7369@cobra.newdream.net>
	<CAGfy=6k3xh_dKJRNiNL_ecKOOXnGWaQT5i2K0Gpz9wW0=C7mWg@mail.gmail.com>
	<alpine.DEB.2.00.1211202217320.1082@cobra.newdream.net>
	<CAGfy=6=7xGcuaDnB72Lp9mey_esU015wCyiTZKPHwEFw=pEuyQ@mail.gmail.com>
	<alpine.DEB.2.00.1211202302390.1082@cobra.newdream.net>
	<CAGfy=6mL5UAeO9EM7VD4BbRRYy2eC8C1HLMu3vvyizYD43NiGw@mail.gmail.com>
	<alpine.DEB.2.00.1211210726110.1082@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52837 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454Ab2KVTKT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:10:19 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so4966252vcm.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 11:10:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211210726110.1082@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Sir,

Thanks for the direction . Here I was using "mount.ceph  monaddr:ip:/
/home/hemant/mntpoint " cmd . Is it possible to do achieve same effect
with "mount.ceph" of what you suggested with "cephfs". (cephfs
/mnt/ceph/foo --pool <poolid>)

But I see that cephfs is able to set which osd to use , the object
size . So can you throw more light on this.


Thanks & Regards,
Hemant Surale.

On Wed, Nov 21, 2012 at 8:59 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 21 Nov 2012, hemant surale wrote:
>> > Oh I see.  Generally speaking, the only way to guarantee separation is to
>> > put them in different pools and distribute the pools across different sets
>> > of OSDs.
>>
>> yeah that was correct approach but i found problem doing so from
>> abstract level i.e. when I put file inside mounted dir
>> "/home/hemant/cephfs " ( mounted using "mount.ceph" cmd ) . At that
>> time anyways ceph is going to use default pool data to store files (
>> here files were striped into different objects and then sent to
>> appropriate osd ) .
>>    So how to tell ceph to use different pools in this case ?
>>
>> Goal : separate read and write operations , where read will be done
>> from one group of OSD and write is done to other group of OSD.
>
> First create the other pool,
>
>  ceph osd pool create <name>
>
> and then adjust the CRUSH rule to distributed to a different set of OSDs
> for that pool.
>
> To allow cephfs use it,
>
>  ceph mds add_data_pool <poolid>
>
> and then:
>
>  cephfs /mnt/ceph/foo --pool <poolid>
>
> will set the policy on the directory such that new files beneath that
> point will be stored in a different pool.
>
> Hope that helps!
> sage
>
>
>>
>>
>>
>>
>> -
>> Hemant Surale.
>>
>>
>> On Wed, Nov 21, 2012 at 12:33 PM, Sage Weil <sage@inktank.com> wrote:
>> > On Wed, 21 Nov 2012, hemant surale wrote:
>> >> Its a little confusing question I believe .
>> >>
>> >> Actually there are two files X & Y.  When I am reading X from its
>> >> primary .I want to make sure simultaneous writing of Y should go to
>> >> any other OSD except primary OSD for X (from where my current read is
>> >> getting served ) .
>> >
>> > Oh I see.  Generally speaking, the only way to guarantee separation is to
>> > put them in different pools and distribute the pools across different sets
>> > of OSDs.  Otherwise, it's all (pseudo)random and you never know.  Usually,
>> > they will be different, particularly as the cluster size increases, but
>> > sometimes they will be the same.
>> >
>> > sage
>> >
>> >
>> >>
>> >>
>> >> -
>> >> Hemant Sural.e
>> >>
>> >> On Wed, Nov 21, 2012 at 11:50 AM, Sage Weil <sage@inktank.com> wrote:
>> >> > On Wed, 21 Nov 2012, hemant surale wrote:
>> >> >> >>    and one more thing how can it be possible to read from one osd and
>> >> >> >> then simultaneous write to direct on other osd with less/no traffic?
>> >> >> >
>> >> >> > I'm not sure I understand the question...
>> >> >>
>> >> >> Scenario :
>> >> >>        I have written file X.txt on some osd which is primary for filr
>> >> >> X.txt ( direct write operation using rados cmd) .
>> >> >>        Now while read on file X.txt is in progress, Can I make sure
>> >> >> the simultaneous write request must be directed to other osd using
>> >> >> crushmaps/other way?
>> >> >
>> >> > Nope.  The object location is based on the name.  Reads and writes go to
>> >> > the same location so that a single OSD can serialize request.  That means,
>> >> > for example, that a read that follows a write returns the just-written
>> >> > data.
>> >> >
>> >> > sage
>> >> >
>> >> >
>> >> >> Goal of task :
>> >> >>        Trying to avoid read - write clashes as much as possible to
>> >> >> achieve faster operations (I/O) . Although CRUSH selects osd for data
>> >> >> placement based on pseudo random function.  is it possible ?
>> >> >>
>> >> >>
>> >> >>
>> >> >> -
>> >> >> Hemant Surale.
>> >> >>
>> >> >>
>> >> >>
>> >> >> On Tue, Nov 20, 2012 at 10:15 PM, Sage Weil <sage@inktank.com> wrote:
>> >> >> > On Tue, 20 Nov 2012, hemant surale wrote:
>> >> >> >> Hi Community,
>> >> >> >>    I have question about port number used by ceph-osd daemon . I
>> >> >> >> observed traffic (inter -osd communication while data ingest happened)
>> >> >> >> on port 6802 and then after some time when I ingested second file
>> >> >> >> after some delay port no 6804 was used . Is there any specific reason
>> >> >> >> to change port no here?
>> >> >> >
>> >> >> > The ports are dynamic.  Daemons bind to a random (6800-6900) port on
>> >> >> > startup and communicate on that.  They discover each other via the
>> >> >> > addresses published in the osdmap when the daemon starts.
>> >> >> >
>> >> >> >>    and one more thing how can it be possible to read from one osd and
>> >> >> >> then simultaneous write to direct on other osd with less/no traffic?
>> >> >> >
>> >> >> > I'm not sure I understand the question...
>> >> >> >
>> >> >> > sage
>> >> >> --
>> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >> >>
>> >> >>
>> >>
>> >>
>>
>>
