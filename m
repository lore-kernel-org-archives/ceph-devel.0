From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: switch "ms bind ipv6" default to "true"?
Date: Wed, 8 Feb 2017 10:32:11 -0700
Message-ID: <CALqRxCxNzeJC3RvR-RFwX-cgL9OaBFPFMqnVPEPGp4PNj9Udkg@mail.gmail.com>
References: <CALqRxCxqUP6V0enicL4EM=aeH1Qt5G0vvmcrqQrmAa9TirpLoQ@mail.gmail.com>
 <1330200336.9468.1486571050945@ox.pcextreme.nl> <alpine.DEB.2.11.1702081658100.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33801 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932853AbdBHRcV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 12:32:21 -0500
Received: by mail-ua0-f179.google.com with SMTP id 35so114740696uak.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2017 09:32:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702081658100.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Feb 8, 2017 at 9:59 AM, Sage Weil <sweil@redhat.com> wrote:
> Currently the messenger *either* uses
> ipv4 or ipv6, but it can't do both.

Oh, ok. I've updated the docs for this, https://github.com/ceph/ceph/pull/13317
