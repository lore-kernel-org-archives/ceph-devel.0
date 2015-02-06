From: Dennis Chen <kernel.org.gnu@gmail.com>
Subject: Re: How to notify an object watched by client via ceph class API
Date: Fri, 6 Feb 2015 11:04:48 +0800
Message-ID: <CA+U0gVg15C=-M_puftpkTLtYCFuGcSMgG2ypkiYWdGF-8npLrQ@mail.gmail.com>
References: <CA+U0gVi=kLnWGbb_Ea=xNGLaRdoxhxGW0HPFT9HUACnHZBM_wg@mail.gmail.com>
 <alpine.DEB.2.00.1502050047370.27042@cobra.newdream.net> <CA+U0gViptMjQkTvvweVGbpB8R9VNJn4-bS34tjjVc5+is=B0Jw@mail.gmail.com>
 <alpine.DEB.2.00.1502050223110.27042@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37080 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbBFDFI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 22:05:08 -0500
Received: by pdbfp1 with SMTP id fp1so11770411pdb.4
        for <ceph-devel@vger.kernel.org>; Thu, 05 Feb 2015 19:05:08 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502050223110.27042@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

On Thu, Feb 5, 2015 at 6:26 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 5 Feb 2015, Dennis Chen wrote:
>> On Thu, Feb 5, 2015 at 4:51 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Thu, 5 Feb 2015, Dennis Chen wrote:
>> >> Hello,
>> >>
>> >> Just as the subject indicated, how can I notify an object watcher
>> >> within a class '.so' loaded into osd deamon. I checked the code and
>> >> found the below op code defined already:CEPH_OSD_OP_NOTIFY, but this
>> >> op code is not used by existing ceph class api, I guest there must be
>> >> a simple solution to resolve this if I don't want to make the osd to
>> >> play client role the same time.
>> >>
>> >> Anyone can help me out this?
>> >>
>> >
>> > The watch/notify does not rely on rados classes, e.g.:
>> >
>> > rados -p rbd create foo
>> > rados -p rbd watch foo &
>> > rados -p rbd notify foo hello
>> >
>> > The notify is just a normal librados operation, and most of those can be
>> > called from classes, but it normally blocks for some period until the
>> > others acknowledge.  If it were wired up in objclass.h you could probably
>> > initiate the async notify but there would be no way to check whether it
>> > ever arrived, so I'm not sure it would be useful.
>> >
>> > What are you trying to accomplish?
>> >
>> > sage
>>
>> What I am trying is to design a signaling control mechanism based on
>> ceph, so the notify will not be in heavy load(just some event state
>> needed to report to the client async). Below is the investigation for
>> this question, initialy the result is good as expected except that the
>> argement transfering between the client watcher callback function and
>> the osd class function, the code snippet:
>>
>> Client side--
>>
>> void notify_test(uint8_t opcode, uint64_t ver, void *arg)
>> {
>>     char *str = (char *)arg;
>>     printf("get notify:%s\n", str);
>
> You are using the v1 watch/notify API.  If you look at master you'll see
> there is a new watch2 operation that gets more useful arguments, like the
> data payload.  (Actually v1 has the data payload too, but I forget where
> it appears.  You should still probably target v2 though!)

I am working on the 0.87 downloaded from the ceph.com, I guest it's OK
for this version since it
has the void *arg.

>> }
>>
>> int main(...)
>> {
>>    ...
>>    strcpy(arg, "notify: from client");
>>    err = rados_watch(io, objname, 0, &handle, notify_test, arg);
>>    err = rados_exec(io, objname, "devctl", "devctl_op", in,
>> strlen(in), out, 128);
>>    ...
>> }
>>
>> OSD side (in the ceph class)--
>> int test_class_ext(cls_method_context_t hctx, bufferlist *in, bufferlist *out)
>> {
>>     int ret;
>>
>>     CLS_LOG(0, "+test_class_ext");
>>     in->append("input data");
>>     out->append("output data");
>
> Note that out content is discarded.  Also, you will never get it, since
> you aren't blocking (and can't inside a class) and won't wait for a reply.
> The "input data" string should get fed to your notify callback on the
> client, though!
>
>>     ReplicatedPG::OpContext **pctx = (ReplicatedPG::OpContext **)hctx;
>>     vector<OSDOp> ops(1);
>>     ops[0].op.op = CEPH_OSD_OP_NOTIFY;
>>     ops[0].indata = *in;
>>     ops[0].outdata = *out;
>
> can just leave outdata NULL.
>
>>     ret = (*pctx)->pg->do_osd_ops(*pctx, ops);
>>     in->claim(ops[0].indata);
>
> This isn't needed, and might be eating your notify payload?
>
>>     out->claim(ops[0].outdata);
>
> not needed

I updated the code according to your suggestion, but still can't pass
any data from this function to the notify callback in the client via
the *arg pointer, that's the problem now. Any one can help about this?


> sage
>
>>     CLS_LOG(0, "ret = %d", ret);
>>
>>     return 0;
>> }
>>
>> static int devctl_op(cls_method_context_t hctx, bufferlist *in, bufferlist *out)
>> {
>>    ...
>>    test_class_ext(hctx, in, out);
>>    return 0;
>> }
>>
>>
>> The output in the client:
>> get notify:notify: from client
>>
>>
>> I can't pass the parameters to the client watcher currently :( , any hints?
>>
>> --
>> Den
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>



-- 
Den
