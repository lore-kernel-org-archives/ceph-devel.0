From: Sage Weil <sage@newdream.net>
Subject: Re: luminous OSD memory usage
Date: Fri, 1 Sep 2017 13:10:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709011308480.20435@piezo.novalocal>
References: <d3b8007f-4bdf-65c5-f4e9-7d1d9c85e019@synesis.ru> <alpine.DEB.2.11.1708301455490.3491@piezo.novalocal> <CAERxPZKokC4j76NMLoc1RLLBS8_cZVkKXavaqF--03LxcF5KJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57477 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdIANKT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Sep 2017 09:10:19 -0400
In-Reply-To: <CAERxPZKokC4j76NMLoc1RLLBS8_cZVkKXavaqF--03LxcF5KJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiaoyan li <wisher2003@gmail.com>
Cc: Aleksei Gutikov <aleksey.gutikov@synesis.ru>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 1 Sep 2017, xiaoyan li wrote:
> On Wed, Aug 30, 2017 at 11:17 PM, Sage Weil <sage@newdream.net> wrote:
> > Hi Aleksei,
> >
> > On Wed, 30 Aug 2017, Aleksei Gutikov wrote:
> >> Hi.
> >>
> >> I'm trying to synchronize osd daemons memory limits and bluestore cache
> >> settings.
> >> For 12.1.4 we have hdd osds usage about 4G with default settings.
> >> For ssds we have limit 6G and they are been oom killed periodically.
> >
> > So,
> >
> >> While
> >> osd_op_num_threads_per_shard_hdd=1
> >> osd_op_num_threads_per_shard_ssd=2
> >> and
> >> osd_op_num_shards_hdd=5
> >> osd_op_num_shards_ssd=8
> >
> > aren't relevant to memory usage.  The _per_shard is about how many bytes
> > are stored in each rocksdb key, and the num_shards is about how many
> > threads we use.
> 
> I can't understand the point about _per_shard. I notice that
> osd_op_num_threads_per_shard is used to set cache shards in BlueStore.

  store->set_cache_shards(get_num_op_shards());

and the osd op queue thread count is then shards * threads_per_shard.

sage
