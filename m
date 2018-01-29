From: Wido den Hollander <wido@42on.com>
Subject: Persistent storage for Mgr Modules
Date: Mon, 29 Jan 2018 10:12:52 +0100
Message-ID: <a813a336-1e16-1d34-cf8b-7179cf04dba0@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se07-out.mail.pcextreme.nl ([185.107.227.76]:58422 "EHLO
        se07-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751273AbeA2JNA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 29 Jan 2018 04:13:00 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm still working on the 'brag' module for the Mgr to send out a report 
every X interval back to the Ceph project so that we get a feeling of 
how people use Ceph.

I'd like to store a timestamp of the last report send and then wait for 
it to expire before sending a new one.

The interval will be something like a week by default and I'd like to 
store it somewhere persistent.

Obviously I can store it in a local variable, but if the Mgr fails or is 
restarted so is the module and thus that data is lost.

Is it OK to use the config-key for this? It's not really configuration, 
but is it allowed to store such values in there?

Thanks,

Wido
