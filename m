From: Shinobu Kinjo <shinobu.kj@gmail.com>
Subject: Re: mon switch from leveldb to rocksdb
Date: Tue, 3 May 2016 06:42:55 +0900
Message-ID: <CAFdRU70KCjhemzL2f2YLKotpVxyarag2WWkTQWny42v6q85dTA@mail.gmail.com>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
	<1707978395.1022.1462224339784@ox.pcextreme.nl>
Reply-To: skinjo@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35896 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbcEBVm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2016 17:42:56 -0400
Received: by mail-io0-f176.google.com with SMTP id u185so5945486iod.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 May 2016 14:42:56 -0700 (PDT)
In-Reply-To: <1707978395.1022.1462224339784@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

If possible, it would be much better to make it pluggable so that we
select what we want.

On Tue, May 3, 2016 at 6:25 AM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 2 mei 2016 om 20:49 schreef Sage Weil <sweil@redhat.com>:
>>
>>
>> We're thinking about switching the default backend on the mon from leveldb
>> to rocksdb.  Rocksdb is better maintained, has a stronger feature set, is
>> generally faster, and is linked statically, which means we won't be
>> vulnerable to buggy distro packages.
>>
>> There is one blocker, though.  Some distro leveldbs name the sst files
>> with the .ldb suffix.  (Some don't; very annoying.)  There is a unit test
>> in rocksdb that tries to verify that ldb is silently renamed to sst,
>> and it passes, but the test is incomplete: the test failes to verify
>> that ldb/sst files can actually be read, and it turns out only the 'check'
>> path (not the normal open and read it path) handles ldb properly.
>>
>> Anyway, once that works, rocksdb will magically upgrade from leveldb to
>> rocksdb.  Note that once that happens you can't switch from rocksdb back
>> to leveldb without recreating the mon.
>>
>> Alternatively, we could not worry about upgrading existing leveldb
>> instances and just make newly created mons default to rocksdb.
>>
>> 1) Thoughts on moving to rocksdb in general?
>>
>> 2) Importance of leveldb->rocksdb conversion?
>>
>
> I would not touch this auto conversion at first. I know there is things to gain, but is it enough to gain that it might be worth while potentially corrupting monitors?
>
> Is it that LevelDB doesn't handle large cluster load for example? Imho the majority of Ceph clusters is still far below 500 OSDs.
>
> Personally I always try to stay away from touching the MONs datastore. Always feels a bit scary.
>
> Wido
>
>> 3) Anyone want to fix the ldb handling in rocksdb?
>>
>> Thanks!
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Email:
shinobu@linux.com
GitHub:
shinobu-x
Blog:
Life with Distributed Computational System based on OpenSource
