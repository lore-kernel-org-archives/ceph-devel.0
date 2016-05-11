From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compile error in Jenkins in rgw/rgw_data_sync.cc
Date: Wed, 11 May 2016 10:35:51 +0200
Message-ID: <0a82ff86-f4dd-1a33-b2c6-983e57a285e1@digiware.nl>
References: <3ab4655e-235d-1d8c-6072-cc796cb51746@digiware.nl>
 <CADRKj5SwFig45NZy7RSuDSKWCFvXT+rYn07ryKzEL9dc_ag5Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:53989 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbcEKIgG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 May 2016 04:36:06 -0400
In-Reply-To: <CADRKj5SwFig45NZy7RSuDSKWCFvXT+rYn07ryKzEL9dc_ag5Nw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 11-5-2016 01:23, Yehuda Sadeh-Weinraub wrote:
> Fixed, reverted offending commit.
> 
> Thanks,
> Yehuda
> 
> On Tue, May 10, 2016 at 3:24 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>
>>   CXX      rgw/librgw_la-rgw_replica_log.lo
>> rgw/rgw_data_sync.cc: In member function 'void
>> RGWDataSyncStatusManager::finalize()':
>> rgw/rgw_data_sync.cc:1383:3: error: 'sync_env' was not declared in this
>> scope
>>    sync_env = RGWDataSyncEnv{};
>>    ^
>>
>> But I'm not sure which sync_env in what class needs exposure.

Thanx,
Will rebase...

--WjW


