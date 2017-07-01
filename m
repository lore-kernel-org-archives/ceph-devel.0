From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: "Unix Domain socket path too long" failures in Jenkins make check
Date: Sat, 1 Jul 2017 23:36:13 +0200
Message-ID: <4d293ea1-11ae-e9bc-5523-51584841c36f@suse.cz>
References: <bf9dcc9d-3c9e-03a5-1be2-f601bed3a18c@suse.cz>
 <5079a3cd-8b60-949f-a413-e159902aa275@digiware.nl>
 <bd8f5518-e9a6-98ac-7f0f-646ac01edd4b@suse.cz>
 <d3bab4db-1a03-13bf-c04a-b28dd8e25939@suse.cz>
 <2b4bf096-1f15-c5f7-2a32-9cdfe88462df@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752059AbdGAVgQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 1 Jul 2017 17:36:16 -0400
In-Reply-To: <2b4bf096-1f15-c5f7-2a32-9cdfe88462df@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sorry, please forget everything I wrote above. The kraken make check 
failure is not a case of "Unix Domain socket path too long", after all. 
(Jenkins is set up to grep the log for certain strings and display them 
as possible causes if they are found, and that string appears in a later 
test, but AFAICT it doesn't cause the test to fail.)

Several tests seem to fail, including the very first test:

   2/156 Test   #1: test-ceph-helpers.sh ....................***Failed 
44.06 sec

The log of that failed test is here: https://paste2.org/DB8z1kzV

Since this is happening on all kraken PRs, it looks like a regression. I 
will bisect.

Nathan
