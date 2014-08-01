From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: bug of bucket instance log list?
Date: Thu, 31 Jul 2014 20:48:21 -0700
Message-ID: <CABBk=J8cL5Qo6cb2Z6hz3C4aHuuG3n_RzBg1kqQB+r7PBZtGQA@mail.gmail.com>
References: <CAOdVJi25jD2Gi19+d8e56eeWPP0MpDWcBrCw747fH1ZqrYeZ=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37923 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbaHADsV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 23:48:21 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so5157627ier.27
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jul 2014 20:48:21 -0700 (PDT)
In-Reply-To: <CAOdVJi25jD2Gi19+d8e56eeWPP0MpDWcBrCw747fH1ZqrYeZ=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: star fan <jfanix@gmail.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 31, 2014 at 8:34 PM, star fan <jfanix@gmail.com> wrote:
> Hi Yehuda,
>
> I think there are logic error about max_entries
> betweenRGWOp_BILog_List::execute() and  store->list_bi_log_entries.
>
> Look at the codes:
> in RGWOp_BILog_List::execute()
>   do {
>
>     list<rgw_bi_log_entry> entries;
>     int ret = store->list_bi_log_entries(bucket_info.bucket,
>                                           marker, max_entries - count,
>                                           entries, &truncated);
>     if (ret < 0) {
>       dout(5) << "ERROR: list_bi_log_entries()" << dendl;
>       return;
>     }
>
>     count += entries.size();
>
>     send_response(entries, marker);
>   } while (truncated && count < max_entries);
>
> and RGWRados::list_bi_log_entries
> int ret = cls_rgw_bi_log_list(index_ctx, oid, marker, max -
> result.size(), entries, truncated);
>
> I think there is a conflict between  "max_entries - count" and "max -
> result.size()".   I think this bug is hard to test since I don't know
> how the bi log creates.
>

Right. Looking at the code, there are a couple of issues. First, as
you pointed out RGWOp_BILog_List::execute() assumes that entries are
cleared within the call to store->list_bi_log_entries(), but the
latter assumes the opposite (that the result is appended). The second
issue that I see is that we shouldn't call to list::size() as it's
O(N).

Thanks,
Yehuda
