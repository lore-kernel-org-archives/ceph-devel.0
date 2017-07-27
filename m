From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: =?utf-8?Q?Re=3A_About__dmclock_theory_defect__=E7=AD=94=E5=A4=8D?=
 =?utf-8?Q?=3A_About_dmClock_tests_confusion_after_integrating_dm?=
 =?utf-8?Q?Clock_QoS_library_into_ceph_codebase?=
Date: Thu, 27 Jul 2017 14:30:13 -0400
Message-ID: <F67D4763-4609-40F7-B4BA-AD71CB009533@redhat.com>
References: <509B214C5E2CEA4D9C41C1AB2A76BDD1A36C50FC@H3CMLB14-EX.srv.huawei-3com.com> <509B214C5E2CEA4D9C41C1AB2A76BDD1A36C512D@H3CMLB14-EX.srv.huawei-3com.com> <509B214C5E2CEA4D9C41C1AB2A76BDD1AF28A20D@H3CMLB12-EX.srv.huawei-3com.com> <509B214C5E2CEA4D9C41C1AB2A76BDD1AF28A22D@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:38508 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdG0SaQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jul 2017 14:30:16 -0400
Received: by mail-qt0-f181.google.com with SMTP id t37so72083840qtg.5
        for <ceph-devel@vger.kernel.org>; Thu, 27 Jul 2017 11:30:15 -0700 (PDT)
In-Reply-To: <509B214C5E2CEA4D9C41C1AB2A76BDD1AF28A22D@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lijie <li.jieA@h3c.com>
Cc: "agulati@vmware.com" <agulati@vmware.com>, "arif@hpl.hp.com" <arif@hpl.hp.com>, "pjv@rice.edu" <pjv@rice.edu>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Jie,

I think you’re right in both cases you describe. There are inherent limitations to any algorithm based on the distribution of requests to multiple servers that are themselves not interchangeable (i.e., a given request must go to a specific server). It seems to me dmclock does a relatively good job without requiring explicit and direct coordination between the servers and instead using the clients to help coordinate the distributed aspect of the algorithm.

Eric

On Jul 4, 2017, at 9:11 PM, Lijie <li.jieA@h3c.com> wrote:
> 
> Hi Eric,
>   We applied dmclock in ceph, but in actual environments only the limitation worked while the reservation and proportion had no real effect at all.
>   After careful analysis, we find that the dmclock algrithm developed from the mclock algrithm, has great defects in theory.
> 
>   First of all , a corepremise of attaining reservation is that all requests which should be scheduled in reservation phase have been completed before
>   it going into proportion phase.This means if the reservation heap has requests with R-tag smaller than current time, it should not process requests
>   in proportion phase. It is very easy to get this point in single server. But in multi-server situation, some servers are in reservation phase while some
>   in proportion phase. So the reservation can not be guaranteed at all.
> 
>   Second of all, a similar problem remains for proportion. Let's consider an extreme situation . There are 2 servers ,S1 and S2;2 clients C1,C2. All of requests
>   from C1 go to S1 while all requests from C2 go to S2. In this case, proportion cannot be guaranteed . And requests are not equally distributed in real wolrd like
>   ceph, which leads to the failure in proportion.
> 
>   So in conclusion,we think that dmclock can only work for limitation in theory.
> 
>   So what about your idea about our conclusion ?

