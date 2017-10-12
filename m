From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: call cls::journal tag_list and take osd loop infinite
Date: Thu, 12 Oct 2017 09:05:49 -0400
Message-ID: <CA+aFP1AmrstV45HJFCyeoWRkMUAqmDRQvbVCK9S7JaYAGRUiNA@mail.gmail.com>
References: <tencent_4F1A27E676A6BBC45AA0B1B0@qq.com> <CA+aFP1DmjH_gPJ37xWf7FmYvNffs8rNY6qRpVLbqR8jRda7kdg@mail.gmail.com>
 <tencent_56FB182B1CA1C33F2BE39C42@qq.com> <CA+aFP1DMbJMJEwVzk=Y8jxBcgmhakRQ1Nu+qyX-KX1+F6_BjYQ@mail.gmail.com>
 <tencent_55CDC52B0FC69A8103091E13@qq.com> <CA+aFP1B3BhteZvBMoDvUGSx_X_r1p8bi55SbZTWi_RBUr269CA@mail.gmail.com>
 <tencent_681F65954102C8D50DB4BB5F@qq.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:47843 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdJLNFw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Oct 2017 09:05:52 -0400
Received: by mail-qt0-f173.google.com with SMTP id z50so13438086qtj.4
        for <ceph-devel@vger.kernel.org>; Thu, 12 Oct 2017 06:05:52 -0700 (PDT)
In-Reply-To: <tencent_681F65954102C8D50DB4BB5F@qq.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5paH5YiY6aOe?= <wenliufei@szsandstone.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for the report! I've opened a PR [1] to fix the issue that was
introduced when the "more" flag was added to "cls_cxx_map_get_vals"
method.

[1] https://github.com/ceph/ceph/pull/18270

On Thu, Oct 12, 2017 at 7:00 AM, 文刘飞 <wenliufei@szsandstone.com> wrote:
>
>  Hi jason,
>     I test the rbd journal in our envirment, and find some osd marked down.
>    the log of osd which marked down is as following:
>
> 2017-10-12 18:45:35.842402 7fcc5b7ff700  1 heartbeat_map is_healthy
> 'OSD::osd_op_tp thread 0x7fcc383ff700' had timed out after 60
> 2017-10-12 18:45:35.842416 7fcc5b7ff700  1 heartbeat_map is_healthy
> 'OSD::osd_op_tp thread 0x7fcc407ff700' had timed out after 60
>
>    and the essential reason of osd_op_tp thread's timeout is  the osd
> trapped in journal_tag_list function.
>    the MAX_KEYS_READS is 64, If cls_cxx_map_get_vals get more than 64
> values, then the more will be true,
> and tag_pass cann't be changed, cls_cxx_map_get_vals will be called
> infinite!
>
>
> int journal_tag_list(cls_method_context_t hctx, bufferlist *in,
>                      bufferlist *out) {
> .....
>
>   std::string last_read = HEADER_KEY_TAG_PREFIX;
>   do {
>     std::map<std::string, bufferlist> vals;
>     bool more;
>     r = cls_cxx_map_get_vals(hctx, last_read, HEADER_KEY_TAG_PREFIX,
>                              MAX_KEYS_READ, &vals, &more);
>     if (r < 0 && r != -ENOENT) {
>       CLS_ERR("failed to retrieve tags: %s", cpp_strerror(r).c_str());
>       return r;
>     }
>   ....
>
>   if (tag_pass != TAG_PASS_DONE && !more) {
>       last_read = HEADER_KEY_TAG_PREFIX;
>       ++tag_pass;
>     } else if (!vals.empty()) {
>       last_read = vals.rbegin()->first;
>     }
>    } while (tag_pass != TAG_PASS_DONE);
>
>   ::encode(tags, *out);
>   return 0;
> }
>
>



-- 
Jason
