From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: How best to integrate dmClock QoS library into ceph codebase
Date: Thu, 29 Jun 2017 14:03:14 -0400
Message-ID: <9c1d41e7-a218-d52b-f17f-0490c3a94d50@redhat.com>
References: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
 <CAF1ivSaa=06CGGJRNQ_9QO_wy6Wc5yK4zbNFiHJLnoJJiqrCSg@mail.gmail.com>
 <f08daf3b-751a-6887-fce0-f5ab38097af4@redhat.com>
 <CAB7xdikG-Pc8DfX7VJv905ZdM8E8wXtfgw_4q693SeNnzDZ63g@mail.gmail.com>
 <cca365ed-5b79-9a56-f683-9db271b842ff@redhat.com>
 <CAB7xdimrWXD7CnEM_yqzO9BzTrwXBq-FyZ2aLcXZL+3m2Z9_Rw@mail.gmail.com>
 <b26c6cec-d021-01ce-0a2b-77484e267635@redhat.com>
 <CAB7xdinUB6dTtc+ncfn7YAH0KKcAg03oxu778NbjHiafiqRnKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:32902 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753034AbdF2SDR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jun 2017 14:03:17 -0400
Received: by mail-qt0-f170.google.com with SMTP id r30so80990712qtc.0
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jun 2017 11:03:16 -0700 (PDT)
In-Reply-To: <CAB7xdinUB6dTtc+ncfn7YAH0KKcAg03oxu778NbjHiafiqRnKQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 06/28/2017 02:55 PM, sheng qiu wrote:
> May I ask do you have any plan to implement client side logic for a
> true "D"mclock, seems to me know it's mclock on each individual OSD.
> And each client also has a common iops config. We are planing to
> working on that part and integrate with your current work.

That is not a high priority in the short-term. Our main goal with
integrating dmclock/mclock was to better manage priorities among
operation classes.

Developers at SK Telecom have done some work towards this, though. For
example, see here:

    https://github.com/ivancich/ceph/pull/1

Eric
