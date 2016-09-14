From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: Best latest commit to run bluestore
Date: Wed, 14 Sep 2016 19:47:32 +0000
Message-ID: <0B017562-31CE-4C51-8ADB-997E5D59C1BF@Teradata.com>
References: <4459A44C-1336-4EC1-82F0-F491D0C83712@Teradata.com>
 <BL2PR02MB2115BE07E99958F8FA8E521CF4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:37778 "EHLO
        rpc7279.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751168AbcINTrf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Sep 2016 15:47:35 -0400
In-Reply-To: <BL2PR02MB2115BE07E99958F8FA8E521CF4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
Content-Language: en-US
Content-ID: <CAA6DA449B74974AA59CA4ADCF568F07@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>


> On Sep 14, 2016, at 12:13 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> 
> Hi Nitin,
> Try with latest master along with the latest rocksdb pull (now should be coming via submodule automatically) , so far it is looking good.
> 
> Thanks & Regards
> Somnath
> 

Hi Somnath,
    Thanks for the quick response.
Nitin

> -----Original Message-----
> From: Kamble, Nitin A [mailto:Nitin.Kamble@Teradata.com]
> Sent: Wednesday, September 14, 2016 12:11 PM
> To: Ceph Development
> Cc: Somnath Roy; Sage Weil
> Subject: Best latest commit to run bluestore
> 
> Hi Sage, Somnath,
> 
> I would like to see how the current bluestore implementation performs with some workload.
> I am following the ceph-devel mailing list, so I am aware there is the memory leak issue in the bluestore code now.
> 
> I also notice that, Somnath has used the master branch recently to generate some benchmark numbers to generate pretty graphs. I do not worry about the loosing the data on the cluster at this point, this is not a production setup, just a experimentation to evaluate current bluestore performance vs filestore.
> 
> I am planning to build the ceph packages from the the latest ceph master branch to do some workload testing on KRBD images backed up by Bluestore. I understand that the master branch is work in progress, can break things,... etc. :)
>  Can you guys suggest me the best and the latest master commit which I should be able use to stress bluestore via krbd for 20+ hours?
>   If nothing comes up to mind, then I can pick the commit Somnath used to generate the pretty graphs.
> 
> Thanks in advance for your help.
> Nitin
> 
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

