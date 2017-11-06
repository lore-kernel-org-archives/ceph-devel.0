From: bhavishya <bhavishya@cse.iitk.ac.in>
Subject: {pg_num} auto-tuning project
Date: Mon, 6 Nov 2017 06:02:07 +0530
Message-ID: <c6f3197f-2f17-efd2-778e-a95efdd1809f@cse.iitk.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.cse.iitk.ac.in ([202.3.77.65]:33706 "EHLO
        smtp.cse.iitk.ac.in" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdKFAZz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Nov 2017 19:25:55 -0500
Received: from [192.168.1.160] (unknown [172.27.24.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bhavishya)
        by smtp.cse.iitk.ac.in (Postfix) with ESMTPSA id 04E8E160345
        for <ceph-devel@vger.kernel.org>; Mon,  6 Nov 2017 05:49:24 +0530 (IST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I'm resending this since last one failed due to html-subpart.

I started to work on {pg_num} autotuning project, needed your advice on 
some aspects:

1)I'll add `pybind/module.py` which uses {pg_calc} formula to calculate 
{pg_num}. But for this I'll need the parameters required for {pg_calc} 
formaula...to get them...what should I do:

--> Use get('pg_summary')['all'] ...but where can I find the complete 
mapping  of  'pg_summary'?
--> In OSDMonitor.cc I did found the ALLCHOICES map but it didn't had 
the all parameters.
--> Anywhere else I should look?

Also any other suggestion regarding this.

Thanks!

