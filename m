From: Jiaying Ren <mikulely@gmail.com>
Subject: Re: RGW: Implement S3 bucket logging feature
Date: Thu, 9 Mar 2017 12:21:51 +0800
Message-ID: <CAF8OO3NtXdD6aM_U56TMXYAGGDMRVD4jduEPPnZc75R7e8aLhg@mail.gmail.com>
References: <CAF8OO3P3UiP+23CLUY0doYJLJNroAm2m5fu5zap6ctr3uP9wtw@mail.gmail.com>
 <CADRKj5S4V+WQxODHMPY4XVtJoFqbdL+Qtj_s0mfGV1UvrfU_sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34595 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdCIEVx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 23:21:53 -0500
Received: by mail-qk0-f182.google.com with SMTP id p64so102144415qke.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Mar 2017 20:21:52 -0800 (PST)
In-Reply-To: <CADRKj5S4V+WQxODHMPY4XVtJoFqbdL+Qtj_s0mfGV1UvrfU_sg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 9 March 2017 at 02:09, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com> wrote:
>> more detailed steps:
>>
>> 1) impl bucket logging HTTP config API
>>    + GET bucket logging
>>    + PUT bucket logging
>>      + store bucket logging config into bucket attribute
>>      + add new entry(<bucket_name,bucket_logging_status>) to a sharded
>>        <bucket_logging.X> rados-object's omap in <.rgw.bl> pool
>>        (<bucket_logging.X>'s omap head store a marker to track
>>        progress)
> I know I was the one to bring up storing this in omap in earlier
> discussion, but maybe instead we could just keep it as data on rados
> objects, and just append it. There's no need to do a random access to
> specific log entries, everything is just being read and written
> serially.

Hi~ Yehuda. Is there any advantages to perfer rados-object over
omap? Or omap has a obvious disadvantages?
