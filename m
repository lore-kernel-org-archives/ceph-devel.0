From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: New Defects reported by Coverity Scan for ceph
Date: Fri, 09 Jan 2015 16:32:06 +0100
Message-ID: <54AFF476.8070208@bisect.de>
References: <54afe6184d25_40e4fa5334803de@scan.coverity.com.mail> <alpine.DEB.2.00.1501090722430.10525@cobra.newdream.net>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33184 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932762AbbAIPvH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 10:51:07 -0500
In-Reply-To: <alpine.DEB.2.00.1501090722430.10525@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Am 09.01.2015 um 16:26 schrieb Sage Weil:
> On Fri, 9 Jan 2015, scan-admin@coverity.com wrote:
>> ** CID 1262114:  Uninitialized scalar field  (UNINIT_CTOR) 
>> /messages/MOSDRepOp.h: 107 in MOSDRepOp::MOSDRepOp()()
>> 
>> ** CID 1262115:  Uninitialized scalar field  (UNINIT_CTOR) 
>> /messages/MOSDRepOpReply.h: 97 in
>> MOSDRepOpReply::MOSDRepOpReply()()
>> 
>> 
>> ________________________________________________________________________________________________________
>>
>> 
*** CID 1262114:  Uninitialized scalar field  (UNINIT_CTOR)
>> /messages/MOSDRepOp.h: 107 in MOSDRepOp::MOSDRepOp()() 101
>> ::encode(from, payload); 102
>> ::encode(updated_hit_set_history, payload); 103
>> ::encode(pg_trim_rollback_to, payload); 104       } 105 106
>> MOSDRepOp()
>>>>> CID 1262114:  Uninitialized scalar field  (UNINIT_CTOR) 
>>>>> Non-static class member "acks_wanted" is not initialized in
>>>>> this constructor nor in any functions that it calls.
>> 107         : Message(MSG_OSD_REPOP, HEAD_VERSION,
>> COMPAT_VERSION) { } 108       MOSDRepOp(osd_reqid_t r, pg_shard_t
>> from, 109     	    spg_t p, const hobject_t& po, int aw, 110
>> epoch_t mape, ceph_tid_t rtid, eversion_t v) 111         :
>> Message(MSG_OSD_REPOP, HEAD_VERSION, COMPAT_VERSION), 112
>> map_epoch(mape),
>> 
>> ________________________________________________________________________________________________________
>>
>> 
*** CID 1262115:  Uninitialized scalar field  (UNINIT_CTOR)
>> /messages/MOSDRepOpReply.h: 97 in
>> MOSDRepOpReply::MOSDRepOpReply()() 91         from(from), 92
>> pgid(req->pgid.pgid, req->from.shard), 93         ack_type(at), 
>> 94         result(result_) { 95         set_tid(req->get_tid()); 
>> 96       }
>>>>> CID 1262115:  Uninitialized scalar field  (UNINIT_CTOR) 
>>>>> Non-static class member "result" is not initialized in this
>>>>> constructor nor in any functions that it calls.
>> 97       MOSDRepOpReply() : Message(MSG_OSD_REPOPREPLY) {} 98
>> private: 99       ~MOSDRepOpReply() {} 100 101     public: 102
>> const char *get_type_name() const { return "osd_repop_reply"; }
> 
> These are both warnings about the trivial constructors,
> 
>> 106       MOSDRepOp()
>>>>> CID 1262114:  Uninitialized scalar field  (UNINIT_CTOR) 
>>>>> Non-static class member "acks_wanted" is not initialized in
>>>>> this constructor nor in any functions that it calls.
>> 107         : Message(MSG_OSD_REPOP, HEAD_VERSION,
>> COMPAT_VERSION) { }
> 
> which are always followed by a ::decode.  We don't initialize
> fields in any of these so we probably have these coverity warnings
> for every message.  Perhaps we should add some annotations to
> indicate that?  Danny, are you familiar with those?
> 
> (I don't think we want to initialize... unless we rely on the
> optimizer to do magic it's inefficient to initialize the value and
> then overwrite it during decode shortly after.)
> 
> sage

I will take a look into it.

Danny

