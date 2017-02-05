From: Ming Lin <minggr@gmail.com>
Subject: Re: understand ceph packets on the wire
Date: Sun, 5 Feb 2017 15:36:18 -0800
Message-ID: <CAF1ivSYQTkTH5U+5uHcPdQoH8yJv+HCfK4Kjd8c_cJnAK1=bzA@mail.gmail.com>
References: <CAF1ivSZtbb_mrSB7gdgO0sszWwZA+r95btd6_AM4VXffNyXq8A@mail.gmail.com>
 <F9477432-C163-44B8-A288-61557DF258F3@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35711 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbdBEXgU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Feb 2017 18:36:20 -0500
Received: by mail-io0-f176.google.com with SMTP id j18so54660201ioe.2
        for <ceph-devel@vger.kernel.org>; Sun, 05 Feb 2017 15:36:20 -0800 (PST)
In-Reply-To: <F9477432-C163-44B8-A288-61557DF258F3@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 3, 2017 at 6:02 PM, LIU, Fei <james.liu@alibaba-inc.com> wrote:
> Hi Ming,
>    Very interesting, for some reason , we can not download the file. Wondering what kind of data the tshark is able to capture?

Just like tcpdump, wireshark/tshark can capture all packets go through
the network interface.
The interesting thing is there is a ceph packet decoder in wireshark/tshark.

https://github.com/wireshark/wireshark/blob/master/epan/dissectors/packet-ceph.c

>
>   Regards,
>   James
