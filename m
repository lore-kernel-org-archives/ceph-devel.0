From: star fan <jfanix@gmail.com>
Subject: bug of bucket instance log list?
Date: Fri, 1 Aug 2014 11:34:20 +0800
Message-ID: <CAOdVJi25jD2Gi19+d8e56eeWPP0MpDWcBrCw747fH1ZqrYeZ=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f195.google.com ([74.125.82.195]:46512 "EHLO
	mail-we0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbaHADeW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 23:34:22 -0400
Received: by mail-we0-f195.google.com with SMTP id p10so1291235wes.2
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jul 2014 20:34:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Hi Yehuda,

I think there are logic error about max_entries
betweenRGWOp_BILog_List::execute() and  store->list_bi_log_entries.

Look at the codes:
in RGWOp_BILog_List::execute()
  do {

    list<rgw_bi_log_entry> entries;
    int ret = store->list_bi_log_entries(bucket_info.bucket,
                                          marker, max_entries - count,
                                          entries, &truncated);
    if (ret < 0) {
      dout(5) << "ERROR: list_bi_log_entries()" << dendl;
      return;
    }

    count += entries.size();

    send_response(entries, marker);
  } while (truncated && count < max_entries);

and RGWRados::list_bi_log_entries
int ret = cls_rgw_bi_log_list(index_ctx, oid, marker, max -
result.size(), entries, truncated);

I think there is a conflict between  "max_entries - count" and "max -
result.size()".   I think this bug is hard to test since I don't know
how the bi log creates.


Vincent
