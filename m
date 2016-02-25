From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: ceph / rocksdb
Date: Thu, 25 Feb 2016 21:21:39 +0100
Message-ID: <56CF6253.7020300@suse.cz>
References: <20160224060546.GC6585@degu.b.linuxbox.com>
 <CALqRxCwrsTv=Lbrc98f7WLqwZxeySiAdq08E0h8a2eNyDU6SPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47615 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933600AbcBYUVm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Feb 2016 15:21:42 -0500
In-Reply-To: <CALqRxCwrsTv=Lbrc98f7WLqwZxeySiAdq08E0h8a2eNyDU6SPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 02/24/2016 06:58 PM, Ken Dreyer wrote:
> I'm really interested in getting our various bundled libraries into
> separate packages.

+1 !

> Does ceph's rocksdb have a lot of changes from rocksdb upstream? If
> so, I'm leaning towards packaging this as "ceph-rocksdb" until those
> changes are present in an upstream rocksdb release.

How about "rocksdb-ceph" for the name? To me the first component 
(rocksdb) expresses what the package *is* (i.e. what you get when you 
install it) and the second component (ceph) expresses the "flavor".

And does this mean I now have a green light for "civetweb-ceph"? ;-)

All the submodules should be separate packages IMO.

Also the tool "ceph-detect-init" seems like it deserves an independent 
existence.

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
