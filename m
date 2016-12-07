From: "=?GBK?B?TElVLCBGZWk=?=" <james.liu@alibaba-inc.com>
Subject: Re: Bluestore with ZS
Date: Wed, 07 Dec 2016 10:02:31 +0800
Message-ID: <58C88472-5B34-42C7-AE9A-ED8B00C61158@alibaba-inc.com>
References: <BY2PR02MB39644AE8ABB2551CC39A46AF4820@BY2PR02MB396.namprd02.prod.outlook.com>
 <ca516a6a-0089-2b7c-95aa-3a21de181f35@redhat.com>
 <BY2PR02MB396443BEF29616A50E014D6F4820@BY2PR02MB396.namprd02.prod.outlook.com>
 <A0D66DA6-605B-4761-A5C9-D52F2D1A6837@alibaba-inc.com>
 <BY2PR02MB396A1E7F05D1247FCA51AC3F4850@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out0-151.mail.aliyun.com ([140.205.0.151]:36953 "EHLO
        out0-151.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbcLGCDd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2016 21:03:33 -0500
In-Reply-To: <BY2PR02MB396A1E7F05D1247FCA51AC3F4850@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Cool, thanks.

Regards,
James

On 12/7/16, 9:29 AM, "Somnath Roy" <Somnath.Roy@sandisk.com> wrote:

    No, as I said, we are in process of optimizing it further with multi kv_sync thread and once it is done , will send out the updated numbers.
    
    Thanks & Regards
    Somnath
    
    -----Original Message-----
    From: LIU, Fei [mailto:james.liu@alibaba-inc.com] 
    Sent: Tuesday, December 06, 2016 5:24 PM
    To: Somnath Roy; Mark Nelson
    Cc: ceph-devel
    Subject: Re: Bluestore with ZS
    
    Hi Somnath,
       Great job. Do you have any latest performance data to share other than the one you sent two weeks ago?
    
      Regards,
      James
    
    On 12/6/16, 11:56 PM, "Somnath Roy" <ceph-devel-owner@vger.kernel.org on behalf of Somnath.Roy@sandisk.com> wrote:
    
        No Problem , take your time..Hopefully, by then we can give you stable multi_kv version.
        
        -----Original Message-----
        From: Mark Nelson [mailto:mnelson@redhat.com] 
        Sent: Tuesday, December 06, 2016 7:54 AM
        To: Somnath Roy
        Cc: ceph-devel
        Subject: Re: Bluestore with ZS
        
        Excellent Somnath!
        
        I will attempt to test this today, though I also am going to be looking at the new RBD erasure coding stuff so it might be a day or two.
        
        Mark
        
        On 12/06/2016 02:33 AM, Somnath Roy wrote:
        > Mark,
        > Please find the Bluestore + ZS integrated code synced with today's master in the following location.
        >
        > https://github.com/somnathr/ceph/tree/wip-bluestore-zs
        >
        > As discussed in the standup , this is with single kv_sync_thread.
        > I am still cleaning up multi kv_sync_thread  version and will send out a pull request for Sage to review hopefully by tomorrow.
        >
        > Here is the steps you need to follow to use this.
        >
        > 1.  ./do_cmake.sh -DWITH_ZS=1
        >
        > 2. make and make install
        >
        > 3. In the ceph.conf , use the following option.
        >
        > enable experimental unrecoverable data corrupting features = bluestore 
        > zs rocksdb bluestore_sync_submit_transaction = false 
        > bluestore_kvbackend=zs
        >
        > With smaller volumes you will be seeing rocks outperforming ZS , but, for bigger volumes ZS is catching up fast.
        > The code (shim layer and thus BlueStore)  is no way optimally using ZS yet and we are in process of optimizing it further (with multi kv_sync, more batching etc. etc.).
        > Will keep community posted on this.
        >
        > Thanks & Regards
        > Somnath
        >
        >
        >
        > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
        >
        --
        To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
        the body of a message to majordomo@vger.kernel.org
        More majordomo info at  http://vger.kernel.org/majordomo-info.html
        
    
    
    


