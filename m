From: Ming Lin <minggr@gmail.com>
Subject: Re: PGLog: optimize trim/rollback with pointer stored in list
Date: Thu, 6 Jul 2017 08:20:54 -0700
Message-ID: <d1458278-b279-7e74-5124-295af550f811@gmail.com>
References: <2263ff96-b9eb-fceb-8257-300f47a65491@gmail.com>
 <alpine.DEB.2.11.1707061428460.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33624 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdGFPU6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 11:20:58 -0400
Received: by mail-pf0-f172.google.com with SMTP id e7so2589714pfk.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Jul 2017 08:20:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707061428460.3424@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 7/6/2017 7:28 AM, Sage Weil wrote:
> On Wed, 5 Jul 2017, Ming Lin wrote:
>> Hi Sage,
>>
>> I didn't send a PR for this patch since it's only for version 10.x.
>> Could you help to review it? Then we'll see whether it's ok to apply it
>> to our production system or not.
> 
> Can we make the same change to master?

Master code is quite different. There is no "list<const pg_log_entry_t>" anymore.

  struct PGLogEntryHandler : public PGLog::LogEntryHandler {
    PG *pg;
    ObjectStore::Transaction *t;
    PGLogEntryHandler(PG *pg, ObjectStore::Transaction *t) : pg(pg), t(t) {}

    // LogEntryHandler
    void remove(const hobject_t &hoid) override {
      pg->get_pgbackend()->remove(hoid, t);
    }
    void try_stash(const hobject_t &hoid, version_t v) override {
      pg->get_pgbackend()->try_stash(hoid, v, t);
    }
    void rollback(const pg_log_entry_t &entry) override {
      assert(entry.can_rollback());
      pg->get_pgbackend()->rollback(entry, t);
    }
    void rollforward(const pg_log_entry_t &entry) override {
      pg->get_pgbackend()->rollforward(entry, t);
    }
    void trim(const pg_log_entry_t &entry) override {
      pg->get_pgbackend()->trim(entry, t);
    }
  };


> 
> sage
