From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Bucket Access Logging Feature
Date: Wed, 10 Aug 2016 08:35:23 -0700
Message-ID: <CADRKj5SsxZVZm15J9MH5GRA3ExAwhSDf=Y70+YU4CwuQ5_MEfA@mail.gmail.com>
References: <CAAkT=OFez++OMSb47JmNvRUx5ONk9nCBdehYEXREd89i9WtoLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:35418 "EHLO
	mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933798AbcHJSZG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 14:25:06 -0400
Received: by mail-ua0-f182.google.com with SMTP id n59so82471628uan.2
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 11:25:06 -0700 (PDT)
In-Reply-To: <CAAkT=OFez++OMSb47JmNvRUx5ONk9nCBdehYEXREd89i9WtoLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rajat Garg <rajatgarg.iitr@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 29, 2016 at 4:31 AM, Rajat Garg <rajatgarg.iitr@gmail.com> wrote:
> Hi cephers,
>
> I am trying to think of a scalable design on how to store bucket logs
> in respective target buckets in every one hour. I had some queries and
> confirmations with the design.
>
> I know that at the moment, radosgw only provides a GetLogging stub
> which returns logging as disabled for a particular bucket. So some
> changes in the following files-:
>
> rgw/rgw_common.h
>       rgw/rgw_log.cc
>       rgw/rgw_main.cc
>        rgw/rgw_op.cc
>     rgw/rgw_op.h
>     rgw/rgw_rest_s3.cc
>     rgw/rgw_rest_s3.h
>
> will enable me to set the the target_bucket for a particular bucket,
> where I can put the operations logs of a particular bucket.
>
> This can be easily done by enabling the "rgw_enable_ops_log" option.
> This logs the bucket ops log to usage_map of rgw_log.cc. Also, there
> is a rados object created corresponding to every bucket every hour for
> the ops.
>

Right. However, I'd try to keep away from the ops log module. The
downside of the ops log is that it writes the log synchronously, thus
severly impacts write performance. Probably extending the usage log to
write bucket ops periodically (and asynchonrously) is a better way to
go.

> Since, I also have to report the logs in the target bucket hourly, I
> am planning to write a callback (with the help of timer function) in
> rgw_log.cc which will be called every 1 hour. This callback will read
> all log objects (through log_list_next call of rgw_rados) and parse
> these objects in a certain file and will then upload this file in the
> target_bucket as radosgw object.
> The callback would look something like-:
>
> http://pastie.org/private/j4d2vihk1tvuzgmzig5ldw
>
>
> After studying the code, I have some questions and design decisions to make-:
> 1. Would writing the callback inside rgw_log.cc and then calling the
> PutObj functions for putting the object in the target bucket, inside
> the callback, work? Or, callback be put in rgw_op.cc (somewhere else)
> would be better?
>
> 2. One more question I have is on on putting the file object in the
> target_bucket, would calling the RGWPutObj::*(pre_exec(),
> verify_permissions(), execute()) be a good way. Or, is there a better
> way to do this.

For both 1,2: probably need to call a lower layer object write
operation, e.g., what RGWPutObj itself calls (go through the object
processor code).

>
> My main question is where to put this callback (because this callback
> should work like garbage collector (I don't know much about the
> garbage collector implementation details) because if I have a cluster
> of 5 radosgw server, I would want to put the log object in the
> target_bucket only once ),
>
>
> Please let me know if your thoughts on this and give suggestions.
>

For a better scaling solution, I'd do something like this:

Keep list of buckets that need logging in omap on multiple shards,
hashed by bucket id.
Log should go to a log object, similar to the ops log, but updated
periodically (as with the usage log).
Periodic thread on rgw should
 - take a lease (rados lock objclass) on one of the buckets log registry shards
 - (while renewing lease) iterate through all the buckets specified
there, for each bucket:
  - create log object for each bucket

Something along these lines.

Thanks,
Yehuda
> Thanks,
> Rajat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
