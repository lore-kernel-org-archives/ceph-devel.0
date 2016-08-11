From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: OSD not coming back up again
Date: Thu, 11 Aug 2016 17:46:05 +0200
Message-ID: <00e4ea05-3821-c3e4-d827-63c82c6c1979@digiware.nl>
References: <bdb93e87-8338-e485-a68d-f988d00f6785@digiware.nl>
 <453729567.2335.1470896803201@ox.pcextreme.nl>
 <5727f9c9-57e0-6256-dbd7-30b73c6feaec@digiware.nl>
 <1788022033.2389.1470915881301@ox.pcextreme.nl>
 <57ca8142-b499-2ccb-7b19-d455b4f8318e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:33385 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932249AbcHKPqO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Aug 2016 11:46:14 -0400
In-Reply-To: <57ca8142-b499-2ccb-7b19-d455b4f8318e@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 11-8-2016 16:36, Willem Jan Withagen wrote:
> On 11-8-2016 13:44, Wido den Hollander wrote:
>> Could be, but the log line which is interesting:
>>
>> 2016-08-11 12:06:16.473351 b69c480 10 osd.0 178 handle_osd_ping osd.2
>> 127.0.0.1:6811/13222 says i am down in 178

I looked in the mon.a log file and there I find repeated messages like:

 mon.a@0(leader)e1 _ms_dispatch existing session 0xabddc80 for osd.0 :/0

Would that mean that there is a session for talking to osd.0 but its
state has not been completed to include the remote address.
And could this be due to an incomplete restart of the connection?

--WjW


