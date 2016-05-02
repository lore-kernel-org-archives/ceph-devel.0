From: Wido den Hollander <wido@42on.com>
Subject: Re: mon switch from leveldb to rocksdb
Date: Mon, 2 May 2016 23:25:39 +0200 (CEST)
Message-ID: <1707978395.1022.1462224339784@ox.pcextreme.nl>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:40321 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbcEBVZo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2016 17:25:44 -0400
In-Reply-To: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org


> Op 2 mei 2016 om 20:49 schreef Sage Weil <sweil@redhat.com>:
> 
> 
> We're thinking about switching the default backend on the mon from leveldb 
> to rocksdb.  Rocksdb is better maintained, has a stronger feature set, is 
> generally faster, and is linked statically, which means we won't be 
> vulnerable to buggy distro packages.
> 
> There is one blocker, though.  Some distro leveldbs name the sst files 
> with the .ldb suffix.  (Some don't; very annoying.)  There is a unit test 
> in rocksdb that tries to verify that ldb is silently renamed to sst, 
> and it passes, but the test is incomplete: the test failes to verify 
> that ldb/sst files can actually be read, and it turns out only the 'check' 
> path (not the normal open and read it path) handles ldb properly.
> 
> Anyway, once that works, rocksdb will magically upgrade from leveldb to 
> rocksdb.  Note that once that happens you can't switch from rocksdb back 
> to leveldb without recreating the mon.
> 
> Alternatively, we could not worry about upgrading existing leveldb 
> instances and just make newly created mons default to rocksdb.
> 
> 1) Thoughts on moving to rocksdb in general?
> 
> 2) Importance of leveldb->rocksdb conversion?
> 

I would not touch this auto conversion at first. I know there is things to gain, but is it enough to gain that it might be worth while potentially corrupting monitors?

Is it that LevelDB doesn't handle large cluster load for example? Imho the majority of Ceph clusters is still far below 500 OSDs.

Personally I always try to stay away from touching the MONs datastore. Always feels a bit scary.

Wido

> 3) Anyone want to fix the ldb handling in rocksdb?
> 
> Thanks!
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
