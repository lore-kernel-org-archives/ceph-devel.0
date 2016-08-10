From: Karl Cronburg <karl.cronburg@gmail.com>
Subject: Histogram output from fio
Date: Wed, 10 Aug 2016 14:17:19 -0400
Message-ID: <CADFviKCiat+2oRANaxyx-GaJp-EmpD1a7hSS-d2SpcsD0CxAtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34712 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932774AbcHJSRV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 14:17:21 -0400
Received: by mail-oi0-f43.google.com with SMTP id l203so70340447oib.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 11:17:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

There are three new parameters to fio which some of you may find useful:

--write_hist_log=[file_prefix - same semantics as --write_lat_log]
--log_hist_msec=[milliseconds between histogram logs - same semantics
as --log_avg_msec]
--log_hist_coarseness=[int from 0 to 6]

This produces *_clat_hist* files. Higher coarseness results in
aggregation of bins (half as many for each increment in coarseness) in
the output log files (fewer bins - smaller log files, less accuracy).
By default (coarseness=0) it produces 1,216 bins per histogram entry
(at least 2KB per fio thread). For anyone interested in the exact
latency values for the bins, see how the following variables are
computed in the post processor:

bin_vals = [ ] # mid-point of each bin
lower_bin_vals = [ ] # lower edge of each bin
upper_bin_vals = [ ] # upper edge of each bin

By default there is a max latency of ~17 seconds in the histogram
bins. I plan to handle this dynamically in fio, but for now you can
recompile fio after doing something like the following:

sed -i.bak 's/^#define FIO_IO_U_PLAT_GROUP_NR 19\n/#define
FIO_IO_U_PLAT_GROUP_NR 24/g' stat.h

Where the '24' gives a max latency of ~9 minutes. This max latency in
no way affects the accuracy of latency percentiles falling below the
max. It can however invalidate the computed average (which I'm
guessing is not usually an interesting statistics anyways).

Post processing tool for getting min/max/percentile/average statistics
(numpy + pandas are dependencies):

    https://github.com/axboe/fio/blob/master/tools/hist/fiologparser_hist.py

Visualization comparing accuracy of *_clat_hist* with *_clat.*:

    https://cronburg.com/fio/demo/latency.html

Slides from the ceph perf meeting:

    https://cronburg.com/fio/MCV_latencies.pdf

Feel free to email me with any questions!

-Karl Cronburg-
