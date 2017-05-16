From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: How best to integrate dmClock QoS library into ceph codebase
Date: Tue, 16 May 2017 08:29:35 -0400
Message-ID: <f08daf3b-751a-6887-fce0-f5ab38097af4@redhat.com>
References: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
 <CAF1ivSaa=06CGGJRNQ_9QO_wy6Wc5yK4zbNFiHJLnoJJiqrCSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752912AbdEPM3r (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 16 May 2017 08:29:47 -0400
In-Reply-To: <CAF1ivSaa=06CGGJRNQ_9QO_wy6Wc5yK4zbNFiHJLnoJJiqrCSg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ming Lin <minggr@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 05/15/2017 10:46 PM, Ming Lin wrote:
> Hi Eric,
> 
> Do you have any integration patches I can have a try?
Hi Ming,

The dmClock library became part of the master branch in early May.

Also, two implementations of the dmClock QoS are in a pull request
currently being reviewed:

    https://github.com/ceph/ceph/pull/14997

Eric

