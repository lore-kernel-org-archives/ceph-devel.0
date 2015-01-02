From: Prithiv M <PMohan0@walmartlabs.com>
Subject: Reg: Ceph Federated Gateway - Primary & Sec Region in one node
Date: Fri, 2 Jan 2015 05:15:53 +0000
Message-ID: <D0CC275F.17192%prithiv@walmartlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppes-mail-e2.wal-mart.com ([161.165.225.16]:48609 "EHLO
	PPES-Mail-E2.wal-mart.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbABGZL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jan 2015 01:25:11 -0500
Content-Language: en-US
Content-ID: <E2918F7C11C9F247851724D42AB1E9A6@email.wal-mart.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "majordomo@vger.kernel.org" <majordomo@vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

i have already posted this question in various ceph users group but I h=
aven't got an answer yet. I am trying to install ceph federated gateway=
 setup with two regions - Master and Secondary with two zones each(prim=
ary and sec), all in one node. I am getting an error =93region map does=
 not specify master region." while creating user for secondary region. =
I have specified different ports for different zones.

Is it possible to install ceph in this setup. If not, why.

JSON FILE FOR MASTER REGION
=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97


{ "name": "us",
  "api_name": "us",
  "is_master": "true",
  "endpoints": [
        "http:\/\/fqdn:80\/"],
  "master_zone": "us-east",
  "zones": [
        { "name": "us-east",
          "endpoints": [
                "http:\/\/fqdn:80\/"],
          "log_meta": "true",
          "log_data": "true"},
        { "name": "us-west",
          "endpoints": [
                "http:\/\/fqdn:81\/"],
          "log_meta": "true",
          "log_data": "true"}],
  "placement_targets": [
   {
     "name": "default-placement",
     "tags": []
   }
  ],
  "default_placement": "default-placement=94}



JSON FILE FOR SEC REGION
=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97

{ "name": "eu",
  "api_name": "eu",
  "is_master": "false",
  "endpoints": [
        "http:\/\/fqdn:82\/"],
  "master_zone": "eu-east",
  "zones": [
        { "name": "eu-east",
          "endpoints": [
                "http:\/\/fqdn:82\/"],
          "log_meta": "true",
          "log_data": "true"},
        { "name": "eu-west",
          "endpoints": [
                "http:\/\/fqdn:83\/"],
          "log_meta": "true",
          "log_data": "true"}],
  "placement_targets": [
   {
     "name": "default-placement",
     "tags": []
   }
  ],
  "default_placement": "default-placement"}

Cheers
Prithiv
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
