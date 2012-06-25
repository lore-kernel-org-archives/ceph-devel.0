From: Florian Haas <florian@hastexo.com>
Subject: radosgw forgetting subuser permissions when creating a fresh key
Date: Mon, 25 Jun 2012 13:57:08 +0200
Message-ID: <CAPUexz-dojn2sgsox0OaMMar=ptYUkExQcQd8=VoyvFe2XCq3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:59213 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2FYL5J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 07:57:09 -0400
Received: by qabj40 with SMTP id j40so1261496qab.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 04:57:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

I wonder if this is intentional: when I create a new Swift key for an
existing subuser, which has previously been assigned "full control"
permissions, those permissions appear to get lost upon key creation.

# radosgw-admin subuser create --uid=johndoe --subuser=johndoe:swift
--access=full
{ "user_id": "johndoe",
  "rados_uid": 0,
  "display_name": "John Doe",
  "email": "john@example.com",
  "suspended": 0,
  "subusers": [
    { "id": "johndoe:swift",
      "permissions": "full-control"}],
  "keys": [
    { "user": "johndoe",
      "access_key": "QFAMEDSJP5DEKJO0DDXY",
      "secret_key": "iaSFLDVvDdQt6lkNzHyW4fPLZugBAI1g17LO0+87"}],
  "swift_keys": []}

Note "permissions": "full-control"

# radosgw-admin key create --subuser=johndoe:swift --key-type=swift
{ "user_id": "johndoe",
  "rados_uid": 0,
  "display_name": "John Doe",
  "email": "john@example.com",
  "suspended": 0,
  "subusers": [
     { "id": "johndoe:swift",
       "permissions": "<none>"}],
  "keys": [
    { "user": "johndoe",
      "access_key": "QFAMEDSJP5DEKJO0DDXY",
      "secret_key": "iaSFLDVvDdQt6lkNzHyW4fPLZugBAI1g17LO0+87"}],
  "swift_keys": [
    { "user": "johndoe:swift",
      "secret_key": "E9T2rUZNu2gxUjcwUBO8n\/Ev4KX6\/GprEuH4qhu1"}]}

Note that while there is now a key, the permissions are gone. Is this
meant to be a security feature of sorts, or is this a bug? "subuser
modify" can obviously restore the permissions, but it seems to be less
than desirable to have to do that.

Cheers,
Florian
