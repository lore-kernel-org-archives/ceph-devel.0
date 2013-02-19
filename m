From: Gregory Farnum <greg@inktank.com>
Subject: Re: Crash and strange things on MDS
Date: Tue, 19 Feb 2013 10:15:48 -0800
Message-ID: <CAPYLRzibP6m3iEBMLs-B2u8t-cjv5-BE8_58dh55h7V2kzXSfQ@mail.gmail.com>
References: <20130204180154.GO3286@kdecherf.com>
	<20130211130518.GN6997@kdecherf.com>
	<CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
	<20130211185424.GA27669@kdecherf.com>
	<CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
	<20130213114750.GC7399@kdecherf.com>
	<CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
	<20130216010217.GA26823@kdecherf.com>
	<CAKMAVE8wv0gx6RYkFxVd3NCSiYDrOc0L42VeL4uq6z3fZMk52A@mail.gmail.com>
	<20130216182403.GB5313@kdecherf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56913 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933261Ab3BSSPu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 13:15:50 -0500
Received: by mail-qc0-f174.google.com with SMTP id z24so2670988qcq.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 10:15:49 -0800 (PST)
In-Reply-To: <20130216182403.GB5313@kdecherf.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Decherf <kevin@kdecherf.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Sat, Feb 16, 2013 at 10:24 AM, Kevin Decherf <kevin@kdecherf.com> wrote:
> On Sat, Feb 16, 2013 at 11:36:09AM -0600, Sam Lang wrote:
>> On Fri, Feb 15, 2013 at 7:02 PM, Kevin Decherf <kevin@kdecherf.com> wrote:
>> > It seems better now, I didn't see any storm so far.
>> >
>> > But we observe high latency on some of our clients (with no load). Does
>> > it exist any documentation on how to read the perfcounters_dump output?
>> > I would like to know if the MDS still has any problem with its cache or
>> > if the latency comes from elsewhere.
>>
>> You can use perfcounters_schema to get the output format in json,
>> using something like json_pp to make it somewhat readable for a human.
>>  You can post the dump output as well and we can try to help you
>> parse/understand what its telling you.
>
> Ok, thanks.
>
> Here you will find the output of perfcounters_dump on the active MDS:
> http://pastebin.com/raw.php?i=BNerQ2fL

Looks like you've got ~424k dentries pinned, and it's trying to keep
400k inodes in cache. So you're still a bit oversubscribed, yes. This
might just be the issue where your clients are keeping a bunch of
inodes cached for the VFS (http://tracker.ceph.com/issues/3289).
-Greg
