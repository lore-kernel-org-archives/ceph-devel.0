From: Jeegn Chen <jeegnchen@gmail.com>
Subject: Question on receive_http_data() in rgw_http_client.cc
Date: Wed, 25 May 2016 11:25:46 +0800
Message-ID: <CAFZHTOa92OZ0wu6xZW_GvGEwz6Xi2KCEOWO3vBdJbEh6MNjkRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:32794 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbcEYDZs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2016 23:25:48 -0400
Received: by mail-lf0-f51.google.com with SMTP id e131so13067657lfb.0
        for <ceph-devel@vger.kernel.org>; Tue, 24 May 2016 20:25:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

According to Ceph 0.94.7, when client->receive_data() encounters some
errors, receive_http_data() just gives a warning log record but still
considers the data of size size * nmemb written and return len = size
* nmemb.
Since receive_http_data is registered as CURLOPT_WRITEFUNCTION, curl
will think the data is properly written and report no errors. Thus the
curl caller may be misled.
The behavior seems not quite reasonable to me.
Is it as designed due to some history?

static size_t receive_http_data(void *ptr, size_t size, size_t nmemb,
void *_info)
{
    RGWHTTPClient *client = static_cast<RGWHTTPClient *>(_info);
    size_t len = size * nmemb;
    int ret = client->receive_data(ptr, size * nmemb);
    if (ret < 0) {
        dout(0) << "WARNING: client->receive_data() returned ret=" <<
ret << dendl;
    }
    return len;
}

Thanks,
Jeegn
