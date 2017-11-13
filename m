From: Liuhao <liu.haoA@h3c.com>
Subject: about memory alignment
Date: Mon, 13 Nov 2017 13:11:18 +0000
Message-ID: <7DF47FD5BC069E4BBD28890C798EC7BC8C8D2EB5@H3CMLB14-EX.srv.huawei-3com.com>
References: <7DF47FD5BC069E4BBD28890C798EC7BC8C8D2E79@H3CMLB14-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.h3c.com ([60.191.123.56]:28367 "EHLO h3cmg01-ex.h3c.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751174AbdKMNLb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Nov 2017 08:11:31 -0500
In-Reply-To: <7DF47FD5BC069E4BBD28890C798EC7BC8C8D2E79@H3CMLB14-EX.srv.huawei-3com.com>
Content-Language: zh-CN
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'ceph-devel' <ceph-devel@vger.kernel.org>

HI, developers:

data.largest_data_off_in_data_bl = orig_len + sizeof(__u32);  // we are about to
What 's mean of sizeof(__u32)?  Why add sizeof(__u32)?

Detail:
oid write(const coll_t& cid, const ghobject_t& oid, uint64_t off, uint64_t len,
                const bufferlist& write_data, uint32_t flags = 0) {
      uint32_t orig_len = data_bl.length();
      Op* _op = _get_next_op();
      _op->op = OP_WRITE;
      _op->cid = _get_coll_id(cid);
      _op->oid = _get_object_id(oid);
      _op->off = off;
      _op->len = len;
      ::encode(write_data, data_bl);

      assert(len == write_data.length());
      data.fadvise_flags = data.fadvise_flags | flags;
      if (write_data.length() > data.largest_data_len) {
         data.largest_data_len = write_data.length();
         data.largest_data_off = off;
         data.largest_data_off_in_data_bl = orig_len + sizeof(__u32);  // we are about to
      }
      data.ops++;
}

Thanks
