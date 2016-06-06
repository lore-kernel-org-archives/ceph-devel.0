From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: ceph / rocksdb
Date: Mon, 6 Jun 2016 12:05:03 +0200
Message-ID: <9a087a20-84bf-dfdb-876d-0c0c4dec1123@digiware.nl>
References: <20160224060546.GC6585@degu.b.linuxbox.com>
 <CALqRxCwrsTv=Lbrc98f7WLqwZxeySiAdq08E0h8a2eNyDU6SPQ@mail.gmail.com>
 <56CF6253.7020300@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:38143 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbcFFKFj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 Jun 2016 06:05:39 -0400
In-Reply-To: <56CF6253.7020300@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 25-2-2016 21:21, Nathan Cutler wrote:
> On 02/24/2016 06:58 PM, Ken Dreyer wrote:
>> I'm really interested in getting our various bundled libraries into
>> separate packages.
> 
> +1 !
> 
>> Does ceph's rocksdb have a lot of changes from rocksdb upstream? If
>> so, I'm leaning towards packaging this as "ceph-rocksdb" until those
>> changes are present in an upstream rocksdb release.
> 
> How about "rocksdb-ceph" for the name? To me the first component
> (rocksdb) expresses what the package *is* (i.e. what you get when you
> install it) and the second component (ceph) expresses the "flavor".
> 
> And does this mean I now have a green light for "civetweb-ceph"? ;-)
> 
> All the submodules should be separate packages IMO.
> 
> Also the tool "ceph-detect-init" seems like it deserves an independent
> existence.
> 

I know that this discussion has run for some time.
And when I build a fresh clone, I ended up with a more recent rocksdb
than that I'd liked....  (or actual Clang)

But 3 trivial fixes further I could again compile, so I've committed
those to the Rocksdb github, and they got accepted this morning.
Now the trick question here is:
	How do they end up in the src/rocksdb tree?

for convenience sake the hashes:
	131397f
	69baec6
	deba7f6

thanx,
--WjW
	
