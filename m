From: "yangruifeng.09209@h3c.com" <yangruifeng.09209@h3c.com>
Subject: about the strtok in the process of creating swift acl policy
Date: Wed, 29 Jul 2015 05:27:08 +0000
Message-ID: <0C3F6DA3760D0C4691E69E5BE224FF495E1466FC@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.h3c.com ([60.191.123.56]:19900 "EHLO h3cmg01-ex.h3c.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751387AbbG2Faq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 01:30:46 -0400
Content-Language: zh-CN
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Is the strtok safe in this case ? why not strtok_r ?

static int parse_list(string& uid_list, vector<string>& uids)
{
  ...
  const char *p = strtok(s, " ,");
  while (p) {
    ...
    p = strtok(NULL, " ,");
  }
  ...
}

bool RGWAccessControlPolicy_SWIFT::create(RGWRados *store, string& id, string& name, string& read_list, string& write_list)
{
  ...
    int r = parse_list(read_list, uids);
  ...
}

Thanks

