From: Casey Bodley <cbodley@redhat.com>
Subject: Re: seastar starting points
Date: Wed, 13 Dec 2017 12:31:02 -0500
Message-ID: <fc7d157d-6117-ab89-606c-656a9fa1585e@redhat.com>
References: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
 <0ebd9a80-e838-7a4f-81ee-f206f9c575ef@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:45033 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbdLMRbF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Dec 2017 12:31:05 -0500
Received: by mail-qt0-f171.google.com with SMTP id m59so4600292qte.11
        for <ceph-devel@vger.kernel.org>; Wed, 13 Dec 2017 09:31:05 -0800 (PST)
In-Reply-To: <0ebd9a80-e838-7a4f-81ee-f206f9c575ef@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <rdias@suse.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org


On 12/13/2017 11:42 AM, Ricardo Dias wrote:
>
>
> On 13-12-2017 16:34, Sage Weil wrote:
>> We had a great chat yesterday with Avi Kivity @ Scylla about seastar in
>> ceph, and were talking about where to start...  One candidate was to 
>> carve
>> off the entire messenger and reimplement using seastar futures/promises.
>
> I don't think it's a good idea to start with the messenger since we 
> are currently making a lot of changes to implement the new V2 protocol.

This seastar messenger would only be used by the seastar-osd. The 
existing messengers will still be used by everything else, so your work 
there is valuable and shouldn't be impacted by the seastar project. 
Whether a new messenger would want to target this v2 protocol from the 
start (and ignore backward compatibility with v1 messengers) is an open 
question.

Casey
