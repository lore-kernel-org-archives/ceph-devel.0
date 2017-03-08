From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: RGW: Implement S3 bucket logging feature
Date: Wed, 8 Mar 2017 10:09:03 -0800
Message-ID: <CADRKj5S4V+WQxODHMPY4XVtJoFqbdL+Qtj_s0mfGV1UvrfU_sg@mail.gmail.com>
References: <CAF8OO3P3UiP+23CLUY0doYJLJNroAm2m5fu5zap6ctr3uP9wtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34690 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753827AbdCHSJQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 13:09:16 -0500
Received: by mail-lf0-f48.google.com with SMTP id k202so18043640lfe.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Mar 2017 10:09:05 -0800 (PST)
In-Reply-To: <CAF8OO3P3UiP+23CLUY0doYJLJNroAm2m5fu5zap6ctr3uP9wtw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jiaying Ren <mikulely@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Mar 8, 2017 at 12:21 AM, Jiaying Ren <mikulely@gmail.com> wrote:
> Hi~ Yehuda and Ceph developers:
>
> We're trying to implement S3 feature bucket
> logging (http://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html).
>
> Currently RGW didn't support bucket
> logging(http://tracker.ceph.com/issues/3225),but has similar
> functionality called opslog.
>
> RGW opslog has its own CLI API,opslog can be accessed only by
> radosgw-admin CLI API(radosgw-admin log list/show). In order to
> compatible with S3, we're trying to adapt current opslog to support
> S3 bucket logging HTTP API via RGW s3 endpoint. Does this make sense
> for RGW? Caz I've found we tried to impl ops log HTTP API via admin
> endpoint(https://github.com/ceph/ceph/pull/7859)

Yes, I think these two efforts could be orthogonal.

>
> If the answer is yes,we'd like to share our plan.The basic idea to
> impl bucket logging takes two steps:
>
> 1) Reuse current ops log (rgw_ops_log_rados)impl as a temp&durable
>    storage(ops log be stored as a rados-object)
> 2) Add a new thread periodically upload opslog rados-object as rgw-object

Pretty much. Keep in mind that old ops log still needs to work the
same way though.

>
> more detailed steps:
>
> 1) impl bucket logging HTTP config API
>    + GET bucket logging
>    + PUT bucket logging
>      + store bucket logging config into bucket attribute
>      + add new entry(<bucket_name,bucket_logging_status>) to a sharded
>        <bucket_logging.X> rados-object's omap in <.rgw.bl> pool
>        (<bucket_logging.X>'s omap head store a marker to track
>        progress)
I know I was the one to bring up storing this in omap in earlier
discussion, but maybe instead we could just keep it as data on rados
objects, and just append it. There's no need to do a random access to
specific log entries, everything is just being read and written
serially. The thread that generates the rgw objects will consume the
entire rados objects, and there will be some kind of prefix that will
designate the current set of objects that log data is being written
to. The thread will change that prefix before starting to create the
rgw objects, making sure that new log entries are written to new rados
objects (needs to have some kind of locking mechanism, it's racy).

>    + ACL support Log Delivery Group
> 2) impl ops log deliver logic
>    + upload rados-object as rgw-object(or to avoid extra data
>      transfer,can we map a rados-obj to a rgw-object by editing its
>      manifiest?)
don't think this optimization is feasible / viable.

>    + (optional) trim opslog

remove all the objects that have any older prefix.

> 3) impl bucket logging CLI API
>    + radosgw-admin bl list // list all bucket logging progress
>    + radosgw-admin bl deliver  // manually deliver ops log
>


Sounds good.

Yehuda

> Any comments are appreciated.Thx.
>
> --
> mikuley
