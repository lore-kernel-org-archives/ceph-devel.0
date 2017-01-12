From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Question about Logging Level
Date: Thu, 12 Jan 2017 09:42:06 +0100
Message-ID: <38ae6067-26cc-908a-9410-62cbf534dcf9@digiware.nl>
References: <CACKY0b-_ZaLCVUwdW4-p6BtPeaAHQ10B-KqjmxuM+Nh5h_xj5A@mail.gmail.com>
 <71ca59e1-2ab3-810a-7738-d89d5359437b@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:12968 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbdALIml (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Jan 2017 03:42:41 -0500
In-Reply-To: <71ca59e1-2ab3-810a-7738-d89d5359437b@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>, liuchang0812 <liuchang0812@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12-1-2017 09:29, Piotr Dałek wrote:
> On 01/12/2017 09:12 AM, liuchang0812 wrote:
>> Hi, all
>>
>> In our documentation, it says that:
>>
>>          Ceph’s logging levels operate on a scale of 1 to 20, where 1
>> is terse and 20 is verbose.
>>
>> http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/#subsystem-log-and-debug-settings
>>
>>
>>
>> But, it seems that there are some logging levels 25 :
>>
>>
>> mds/MDBalancer.cc:276:  dout(25) << "=== got heartbeat " <<
>> m->get_beat() << " from " << m->get_source().num() << " " <<
>> m->get_load() << dendl;
>> mds/CInode.cc:4189:  dout(25) << __func__ << dendl;
>> mds/MDCache.cc:11656:    //dout(25) << "saw depth " << d << " " <<
>> *dir << dendl;
>> mds/MDCache.cc:11666:   //dout(25) << " saw sub " << **p << dendl;
>> mds/journal.cc:373:      dout(25) << "EMetaBlob::add_dir_context(" <<
>> dir << ")      maybe " <<
>>
>>
>> So, shoud we update our documentation, or update logging level to 20?
> 
> I've seen douts on levels as high as 35, so if this is really
> concerning, we could update docs to reflect the fact that level 20 is
> usually the most verbose, with some rare exceptions that may be useful
> for devs with deep knowledge of Ceph code or devs responsible for
> particular piece of code.

Level is just an integer, so it can go all the way upto MAX_INT.

I've set levels at > 20 to sort of indicate/suggest/imply that this only
for the very serious debugging.
And certainly at those levels it will be very, very verbose. Like
logging all function entry and exits.

I would not bother educating regular users too much about this.

--WjW
--WjW

