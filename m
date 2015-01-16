From: Wido den Hollander <wido@42on.com>
Subject: Re: MDS aborted after recovery and active, FAILED assert (r >=0)
Date: Fri, 16 Jan 2015 09:52:15 +0100
Message-ID: <54B8D13F.6080408@42on.com>
References: <20DBB415DF55354C8FC7AF12F4AE770024D3233A@MBX02-TPM.mimos.local> <54B8C256.3060706@42on.com> <20DBB415DF55354C8FC7AF12F4AE770024D32379@MBX02-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:41298 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbbAPIwS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 16 Jan 2015 03:52:18 -0500
In-Reply-To: <20DBB415DF55354C8FC7AF12F4AE770024D32379@MBX02-TPM.mimos.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mohd Bazli Ab Karim <bazli.abkarim@mimos.my>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/16/2015 09:36 AM, Mohd Bazli Ab Karim wrote:
> Agree. I was about to upgrade to 0.90, but has postponed it due to this error.
> Any chance for me to recover it first before upgrading it?
> 

I'm not sure, but I think you won't be able to recover this under 0.72.

> Thanks Wido.
> 
> Regards,
> Bazli
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wido den Hollander
> Sent: Friday, January 16, 2015 3:50 PM
> To: Mohd Bazli Ab Karim; ceph-users@lists.ceph.com; ceph-devel@vger.kernel.org
> Subject: Re: MDS aborted after recovery and active, FAILED assert (r >=0)
> 
> On 01/16/2015 08:37 AM, Mohd Bazli Ab Karim wrote:
>> Dear Ceph-Users, Ceph-Devel,
>>
>> Apologize me if you get double post of this email.
>>
>> I am running a ceph cluster version 0.72.2 and one MDS (in fact, it's 3, 2 down and only 1 up) at the moment.
>> Plus I have one CephFS client mounted to it.
>>
> 
> In Ceph world 0.72.2 is ancient en pretty old. If you want to play with CephFS I recommend you upgrade to 0.90 and also use at least kernel 3.18
> 
>> Now, the MDS always get aborted after recovery and active for 4 secs.
>> Some parts of the log are as below:
>>
>>     -3> 2015-01-15 14:10:28.464706 7fbcc8226700  1 --
>> 10.4.118.21:6800/5390 <== osd.19 10.4.118.32:6821/243161 73 ====
>> osd_op_re
>> ply(3742 1000240c57e.00000000 [create 0~0,setxattr (99)]
>> v56640'1871414 uv1871414 ondisk = 0) v6 ==== 221+0+0 (261801329 0 0)
>> 0x
>> 7770bc80 con 0x69c7dc0
>>     -2> 2015-01-15 14:10:28.464730 7fbcc8226700  1 --
>> 10.4.118.21:6800/5390 <== osd.18 10.4.118.32:6818/243072 67 ====
>> osd_op_re
>> ply(3645 1000007941c.00000000 [tmapup 0~0] v56640'1769567 uv1769567
>> ondisk = 0) v6 ==== 179+0+0 (3759887079 0 0) 0x7757ec80 con
>> 0x1c6bb00
>>     -1> 2015-01-15 14:10:28.464754 7fbcc8226700  1 --
>> 10.4.118.21:6800/5390 <== osd.47 10.4.118.35:6809/8290 79 ====
>> osd_op_repl
>> y(3419 mds_anchortable [writefull 0~94394932] v0'0 uv0 ondisk = -90
>> (Message too long)) v6 ==== 174+0+0 (3942056372 0 0) 0x69f94
>> a00 con 0x1c6b9a0
>>      0> 2015-01-15 14:10:28.471684 7fbcc8226700 -1 mds/MDSTable.cc: In
>> function 'void MDSTable::save_2(int, version_t)' thread 7
>> fbcc8226700 time 2015-01-15 14:10:28.469999
>> mds/MDSTable.cc: 83: FAILED assert(r >= 0)
>>
>>  ceph version  ()
>>  1: (MDSTable::save_2(int, unsigned long)+0x325) [0x769e25]
>>  2: (Context::complete(int)+0x9) [0x568d29]
>>  3: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0x1097) [0x7c15d7]
>>  4: (MDS::handle_core_message(Message*)+0x5a0) [0x588900]
>>  5: (MDS::_dispatch(Message*)+0x2f) [0x58908f]
>>  6: (MDS::ms_dispatch(Message*)+0x1e3) [0x58ab93]
>>  7: (DispatchQueue::entry()+0x549) [0x975739]
>>  8: (DispatchQueue::DispatchThread::entry()+0xd) [0x8902dd]
>>  9: (()+0x7e9a) [0x7fbcccb0de9a]
>>  10: (clone()+0x6d) [0x7fbccb4ba3fd]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>>
>> Is there any workaround/patch to fix this issue? Let me know if need to see the log with debug-mds of certain level as well.
>> Any helps would be very much appreciated.
>>
>> Thanks.
>> Bazli
>>
>> ________________________________
>> DISCLAIMER:
>>
>>
>> This e-mail (including any attachments) is for the addressee(s) only and may be confidential, especially as regards personal data. If you are not the intended recipient, please note that any dealing, review, distribution, printing, copying or use of this e-mail is strictly prohibited. If you have received this email in error, please notify the sender immediately and delete the original message (including any attachments).
>>
>>
>> MIMOS Berhad is a research and development institution under the purview of the Malaysian Ministry of Science, Technology and Innovation. Opinions, conclusions and other information in this e-mail that do not relate to the official business of MIMOS Berhad and/or its subsidiaries shall be understood as neither given nor endorsed by MIMOS Berhad and/or its subsidiaries and neither MIMOS Berhad nor its subsidiaries accepts responsibility for the same. All liability arising from or in connection with computer viruses and/or corrupted e-mails is excluded to the fullest extent permitted by law.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
> --
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
> 
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> ________________________________
> DISCLAIMER:
> 
> 
> This e-mail (including any attachments) is for the addressee(s) only and may be confidential, especially as regards personal data. If you are not the intended recipient, please note that any dealing, review, distribution, printing, copying or use of this e-mail is strictly prohibited. If you have received this email in error, please notify the sender immediately and delete the original message (including any attachments).
> 
> 
> MIMOS Berhad is a research and development institution under the purview of the Malaysian Ministry of Science, Technology and Innovation. Opinions, conclusions and other information in this e-mail that do not relate to the official business of MIMOS Berhad and/or its subsidiaries shall be understood as neither given nor endorsed by MIMOS Berhad and/or its subsidiaries and neither MIMOS Berhad nor its subsidiaries accepts responsibility for the same. All liability arising from or in connection with computer viruses and/or corrupted e-mails is excluded to the fullest extent permitted by law.
> 
> ------------------------------------------------------------------
> -
> -
> DISCLAIMER: 
> 
> This e-mail (including any attachments) is for the addressee(s) 
> only and may contain confidential information. If you are not the 
> intended recipient, please note that any dealing, review, 
> distribution, printing, copying or use of this e-mail is strictly 
> prohibited. If you have received this email in error, please notify 
> the sender  immediately and delete the original message. 
> MIMOS Berhad is a research and development institution under 
> the purview of the Malaysian Ministry of Science, Technology and 
> Innovation. Opinions, conclusions and other information in this e-
> mail that do not relate to the official business of MIMOS Berhad 
> and/or its subsidiaries shall be understood as neither given nor 
> endorsed by MIMOS Berhad and/or its subsidiaries and neither 
> MIMOS Berhad nor its subsidiaries accepts responsibility for the 
> same. All liability arising from or in connection with computer 
> viruses and/or corrupted e-mails is excluded to the fullest extent 
> permitted by law.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
