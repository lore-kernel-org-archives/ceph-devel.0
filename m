From: Nathan Howell <nathan.d.howell@gmail.com>
Subject: Re: Cephfs losing files and corrupting others
Date: Thu, 22 Nov 2012 23:37:15 -0800
Message-ID: <CAD84eiEsDxtq8-1wi8pbBfjd28woduO5vkoPk-rg7U_H8M+w2Q@mail.gmail.com>
References: <CAD84eiF1dcE5buvTyFctXTSvB4bgEYXtpxwX7yJWiOEASmNvJA@mail.gmail.com>
	<5092F860.7040708@inktank.com>
	<CAD84eiHm84hOAi-VdgVZPvfRWOHCup6sWXpJHGvV+Wcd9sA6vQ@mail.gmail.com>
	<CAPYLRzguxttjgCVCsFF95y18UGPL9D318=R5cGRjCrwAAEMzSA@mail.gmail.com>
	<CAD84eiEDMXiXf8aFojpAFJPt=5DVZNFbnNq9BnJBxMzRrdNjrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58940 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531Ab2KWHhW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 02:37:22 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so8714110obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 23:37:16 -0800 (PST)
In-Reply-To: <CAD84eiEDMXiXf8aFojpAFJPt=5DVZNFbnNq9BnJBxMzRrdNjrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, Sam Lang <sam.lang@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

I upgraded to 0.54 and now there are some hints in the logs. The
directories referenced in the log entries are now missing:

2012-11-23 07:28:04.802864 mds.0 [ERR] loaded dup inode 1000000662f
[2,head] v3851654 at /xxx/20120203, but inode 1000000662f.head
v3853093 already exists at ~mds0/stray7/1000000662f
2012-11-23 07:28:04.802889 mds.0 [ERR] loaded dup inode 10000003a4b
[2,head] v431518 at /xxx/20120206, but inode 10000003a4b.head v3853192
already exists at ~mds0/stray8/10000003a4b
2012-11-23 07:28:04.802909 mds.0 [ERR] loaded dup inode 1000000149e
[2,head] v431522 at /xxx/20120207, but inode 1000000149e.head v3853206
already exists at ~mds0/stray8/1000000149e
2012-11-23 07:28:04.802927 mds.0 [ERR] loaded dup inode 10000000a5f
[2,head] v431526 at /xxx/20120208, but inode 10000000a5f.head v3853208
already exists at ~mds0/stray8/10000000a5f

Any ideas?

On Thu, Nov 15, 2012 at 11:00 AM, Nathan Howell
<nathan.d.howell@gmail.com> wrote:
> Yes, successfully written files were disappearing. We switched to ceph-fuse
> and haven't seen any files truncated since. Older files (written months ago)
> are still having their entire contents replaced with NULL bytes, seemly at
> random. I can't yet say for sure this has happened since switching over to
> fuse... but we think it has.
>
> I'm going to test all of the archives over the next few days and restore
> them from S3, so we should be back in a known-good state after that. In the
> event more files end up corrupted, is there any logging that I can enable
> that would help track down the problem?
>
> thanks,
> -n
>
>
> On Sat, Nov 3, 2012 at 9:54 AM, Gregory Farnum <greg@inktank.com> wrote:
>>
>> On Fri, Nov 2, 2012 at 12:30 AM, Nathan Howell
>> <nathan.d.howell@gmail.com> wrote:
>> > On Thu, Nov 1, 2012 at 3:32 PM, Sam Lang <sam.lang@inktank.com> wrote:
>> >> Do the writes succeed?  I.e. the programs creating the files don't get
>> >> errors back?  Are you seeing any problems with the ceph mds or osd
>> >> processes
>> >> crashing?  Can you describe your I/O workload during these bulk loads?
>> >> How
>> >> many files, how much data, multiple clients writing, etc.
>> >>
>> >> As far as I know, there haven't been any fixes to 0.48.2 to resolve
>> >> problems
>> >> like yours.  You might try the ceph fuse client to see if you get the
>> >> same
>> >> behavior.  If not, then at least we have narrowed down the problem to
>> >> the
>> >> ceph kernel client.
>> >
>> > Yes, the writes succeed. Wednesday's failure looked like this:
>> >
>> > 1) rsync 100-200mb tarball directly into ceph from a remote site
>> > 2) untar ~500 files from tarball in ceph into a new directory in ceph
>> > 3) wait for a while
>> > 4) the .tar file and some log files disappeared but the untarred files
>> > were fine
>>
>> Just to be clear, you copied a tarball into Ceph and untarred all in
>> Ceph, and the extracted contents were fine but the tarball
>> disappeared? So this looks like a case of successfully-written files
>> disappearing?
>> Did you at any point check the tarball from a machine other than the
>> initial client that copied it in?
>>
>> This truncation sounds like maybe Yan's fix will deal with it. But if
>> you've also seen files with the proper size but be empty or corrupted,
>> that sounds like an OSD bug. Sam, are you aware of any btrfs issues
>> that could cause this?
>>
>> Nathan, you've also seen parts of the filesystem hierarchy get lost?
>> That's rather more concerning; under what circumstances have you seen
>> that?
>> -Greg
>>
>> > Total filesystem size is:
>> >
>> > pgmap v2221244: 960 pgs: 960 active+clean; 2418 GB data, 7293 GB used,
>> > 6151 GB / 13972 GB avail
>> >
>> > Generally our load looks like:
>> >
>> > Constant trickle of 1-2mb files from 3 machines, about 1GB per day
>> > total. No file is written to by more than 1 machine, but the files go
>> > into shared directories.
>> >
>> > Grid jobs are running constantly and are doing sequential reads from
>> > the filesystem. Compute nodes have the filesystem mounted read-only.
>> > They're primarily located at a remote site (~40ms away) and tend to
>> > average 1-2 megabits/sec.
>> >
>> > Nightly data jobs load in ~10GB from a few remote sites in to <10
>> > large files. These are split up into about 1000 smaller files but the
>> > originals are also kept. All of this is done on one machine. The
>> > journals and osd drives are write saturated while this is going on.
>> >
>> >
>> > On Thu, Nov 1, 2012 at 4:02 PM, Gregory Farnum <greg@inktank.com> wrote:
>> >> Are you using hard links, by any chance?
>> >
>> > No, we are using a handfull of soft links though.
>> >
>> >
>> >> Do you have one or many MDS systems?
>> >
>> > ceph mds stat says: e686: 1/1/1 up {0=xxx=up:active}, 2 up:standby
>> >
>> >
>> >> What filesystem are you using on your OSDs?
>> >
>> > btrfs
>> >
>> >
>> > thanks,
>> > -n
>
>
