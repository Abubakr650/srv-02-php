<?php
/**
 * srv-02 - PHP Version
 * مكافئ للكود C# الأصلي
 * يعرض معلومات عشوائية عن Amazon S3
 */

$s3_facts = [
    "Scale storage resources to meet fluctuating needs with 99.999999999% (11 9s) of data durability.",
    "Store data across Amazon S3 storage classes to reduce costs without upfront investment or hardware refresh cycles.",
    "Protect your data with unmatched security, compliance, and audit capabilities.",
    "Easily manage data at any scale with robust access controls, flexible replication tools, and organization-wide visibility.",
    "Run big data analytics, artificial intelligence (AI), machine learning (ML), and high performance computing (HPC) applications.",
    "Meet Recovery Time Objectives (RTO), Recovery Point Objectives (RPO), and compliance requirements with S3's robust replication features."
];

// اختيار معلومة عشوائية
$i = rand(0, count($s3_facts) - 1);

// الوقت الحالي
$time = date('H:i:s');

// الرد
header('Content-Type: text/plain; charset=utf-8');
http_response_code(200);

echo $time . " - " . $s3_facts[$i];
