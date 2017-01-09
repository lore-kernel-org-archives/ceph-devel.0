From: liuchang0812 <liuchang0812@gmail.com>
Subject: collect S3 error messages
Date: Mon, 9 Jan 2017 21:23:42 +0800
Message-ID: <CACKY0b8ra97EBzGS7QK1JDgWkSp+1=_Rx0cQozj_0JKqKpAPEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34120 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760890AbdAINXn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 08:23:43 -0500
Received: by mail-yw0-f176.google.com with SMTP id w75so26408853ywg.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2017 05:23:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi, all

Our RGW has a bug: http://tracker.ceph.com/issues/18241

According to the AWS documentation the Code element in an error
response for Multi-Object Delete should be a string with values
resembling codes we usually convey as rgw_http_errors::s3_code.
Code
Status code for the result of the failed delete. .
Type: String
Values: AccessDenied, InternalError
Ancestor: Error
Actually we are dumping Code as int with HTTP response number. In
RGWDeleteMultiObj_ObjStore_S3::send_partial_response we have:
      s->formatter->open_object_section("Error");
      err_no = -op_ret;
      rgw_get_errno_s3(&r, err_no);
      s->formatter->dump_string("Key", key.name);
      s->formatter->dump_string("VersionId", key.instance);
      s->formatter->dump_int("Code", r.http_ret);
      s->formatter->dump_string("Message", r.s3_code);
      s->formatter->close_section();



We need to collect "error message" for RGW, as discuss with @Yehudasa,
I have created a gdoc which could be commented by anyone. Please help
us to correct those MESSAGEs

Google Doc URL is
https://docs.google.com/document/d/1iDpqOrVulZbEDXUM_LTsb8IBydNyu4i9CpMDQiM8ARY/edit?usp=sharing

Any comments would be appreciated! Thanks
