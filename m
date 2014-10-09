From: Gregory Farnum <greg@inktank.com>
Subject: Re: [Ceph-qa] New Defects reported by Coverity Scan for ceph
Date: Thu, 9 Oct 2014 11:20:39 -0700
Message-ID: <CAPYLRziEA7fUgKAp2oGHjyNdKgNhErV3_VE9Vr1wqB5H9v06zA@mail.gmail.com>
References: <54368c5d7dba5_4b3c927318474b4@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:37318 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbaJISUk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Oct 2014 14:20:40 -0400
Received: by mail-qg0-f52.google.com with SMTP id q108so2799695qgd.11
        for <ceph-devel@vger.kernel.org>; Thu, 09 Oct 2014 11:20:40 -0700 (PDT)
In-Reply-To: <54368c5d7dba5_4b3c927318474b4@scan.coverity.com.mail>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Zheng Yan <ukernel@gmail.com>
Cc: ceph-qa <ceph-qa@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, John Spray <john.spray@inktank.com>

On Thu, Oct 9, 2014 at 6:23 AM,  <scan-admin@coverity.com> wrote:
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.
>
> 3 new defect(s) introduced to ceph found with Coverity Scan.
> 4 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.
>
> New defect(s) Reported-by: Coverity Scan
> Showing 3 of 3 defect(s)
>
>
> ** CID 1244227:  Dereference after null check  (FORWARD_NULL)
> /mds/Server.cc: 7011 in Server::do_rename_rollback(ceph::buffer::list &, mds_rank_t, std::tr1::shared_ptr<MDRequestImpl> &, bool)()
> /mds/Server.cc: 7130 in Server::do_rename_rollback(ceph::buffer::list &, mds_rank_t, std::tr1::shared_ptr<MDRequestImpl> &, bool)()

These lines are
if (in && in->is_dir() && srcdn->authority().first != whoami) ...
and
} else if (force_journal_src || (in && in->is_dir() &&
srcdn->authority().first == whoami)) { ...

Coverity is complaining about the srcdn dereference, and I've dug into
it a bit but I think this might actually be an issue. Well, more
accurately, I think maybe if srcdn is NULL we've failed somehow and
should have given up, but the code looks to be not failing on purpose,
so I'm missing something. We should dig into this and either fix or
promote the
    if (in && in->is_dir())
      assert(srcdn && destdn);
which we have nested inside of a check for rollback.orig_src.ino (ie,
we were auth/primary for the srcdn at rename time).

The other two I've sent in an (untested) PR for:
https://github.com/ceph/ceph/pull/2677

>
> ** CID 1244228:  Uninitialized scalar field  (UNINIT_CTOR)
> /mds/MDSAuthCaps.h: 29 in MDSCapSpec::MDSCapSpec()()

The "read" cap bool is indeed uninitialized; easy enough to
default-fill it to false.

> ** CID 1244229:  Uninitialized scalar field  (UNINIT_CTOR)
> /messages/MDirUpdate.h: 55 in MDirUpdate::MDirUpdate(mds_rank_t, dirfrag_t, int, std::set<int, std::less<int>, std::allocator<int>> &, filepath &, bool)()

"discover" is indeed uninitialized by default (although it looks like
the only caller overrides that default). The PR sets it to 0, which
appears to be the correct default from my reading of the code.
-Greg
